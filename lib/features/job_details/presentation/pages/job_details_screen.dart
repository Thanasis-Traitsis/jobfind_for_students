// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../applicants_list/presentation/applicants_list_bloc/applicants_list_bloc.dart';
import '../../../listings/data/models/job_model.dart';
import '../../../listings/domain/usecases/transform_isFavourite.dart';
import '../../../listings/domain/usecases/transform_views.dart';
import '../../../listings/presentation/job_card_bloc/job_card_bloc.dart';
import '../../../new_listing/data/repositories/new_listings_repositories_impl.dart';
import '../../../new_listing/domain/usecases/get_major_ids.dart';
import '../../../profile/domain/usecases/get_listing_body.dart';
import '../job_details_bloc/job_details_bloc.dart';
import '../widgets/details_card.dart';
import '../widgets/floating_full_width_button.dart';
import '../widgets/is_favourite_icon.dart';
import '../widgets/more_text_container.dart';

class JobDetailsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final JobModel job;
  final bool isCompany;

  const JobDetailsScreen({
    Key? key,
    required this.scaffoldMessengerKey,
    required this.job,
    required this.isCompany,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasBeenViewed = transformIntToBoolean(job.hasViewed);
    bool hasApplied = transformIntToBoolean(job.hasApplied);

    if (!hasBeenViewed) {
      BlocProvider.of<JobCardBloc>(context).add(
        JobDetailsButtonPressed(
          jobId: job.id.toString(),
          views: int.parse(transformViews(job.views)),
        ),
      );
    }

    BlocProvider.of<JobDetailsBloc>(context).add(
      ParagraphButtonPressed(
        section: job.description!,
      ),
    );

    onSetJobsToFavourite(String id, int? isFav) async {
      BlocProvider.of<JobCardBloc>(context).add(
        ToggleFavouriteEvent(
          jobId: id,
        ),
      );
    }

    onSubmitToJob() {
      BlocProvider.of<JobCardBloc>(context).add(
        ToggleApplyEvent(
          jobId: job.id.toString(),
        ),
      );
    }

    onApplicantsScreen() {
      BlocProvider.of<ApplicantsListBloc>(context).add(
        GetApplicantsListForThisJob(jobId: job.id.toString()),
      );

      context.push(PAGES.applicantsList.screenPath);
    }

    onParagraphButtonPressed(String section) async {
      BlocProvider.of<JobDetailsBloc>(context).add(
        ParagraphButtonPressed(section: section),
      );
    }

    return Scaffold(
      floatingActionButton: isCompany
          ? job.applicants_count != null
              ? FloatingFullWidthButton(
                  hasApplied: false,
                  function: onApplicantsScreen,
                  isMyJob: true,
                  applicantsCount: job.applicants_count,
                )
              : null
          : FloatingFullWidthButton(
              hasApplied: hasApplied,
              function: onSubmitToJob,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        title: Text(
          'Περιγραφή',
          style: TextStyle(
            fontSize: calculateFontSize(
              context,
              veryLargeText,
            ),
          ),
        ),
        actions: [
          isCompany
              ? job.applicants_count != null
                  ? IconButton(
                      onPressed: () async {
                        List data =
                            await NewListingsRepositoriesImpl().getAcademia();

                        List majordIds = await getMajorIds(job.id.toString());

                        await getListingBody().then((value) {
                          Map values = {};

                          for (var i = 0; i < value.length; i++) {
                            values[value[i]] = value[i] == 'employment_type'
                                ? job.toJson()['employmentType']
                                : job.toJson()[value[i]];
                          }

                          context.pushNamed(
                            PAGES.newListing.screenName,
                            extra: [
                              value,
                              data[0],
                              data[1],
                              data[2],
                              values,
                              majordIds,
                              job.id.toString(),
                            ],
                          );
                        });
                      },
                      icon: const Icon(FontAwesomeIcons.penToSquare),
                    )
                  : Container()
              : BlocBuilder<JobCardBloc, JobCardState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        onSetJobsToFavourite(
                          job.id.toString(),
                          job.isFavourite,
                        );
                      },
                      icon: state is JobCardFavourite
                          ? IsFavouriteICon(
                              isFav: state.isFav,
                            )
                          : IsFavouriteICon(
                              isFav: transformIntToBoolean(
                                job.isFavourite,
                              ),
                            ),
                    );
                  },
                )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: padding,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DetailsCard(
                  context: context,
                  job: job,
                ),
                const SizedBox(
                  height: gap * 2,
                ),
                MoreTextContainer(
                  job: job,
                  function: onParagraphButtonPressed,
                  noNeedBottomSpace:
                      isCompany ? job.applicants_count == null : false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
