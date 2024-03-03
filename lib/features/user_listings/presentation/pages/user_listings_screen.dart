import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/list_is_empty_message.dart';
import '../../../applicants_list/presentation/applicants_list_bloc/applicants_list_bloc.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/usecases/boolean_is_company.dart';
import '../../../auth/domain/usecases/update_apply_status.dart';
import '../../../auth/domain/usecases/update_favourite_status.dart';
import '../../../auth/presentation/widgets/responsive_card.dart';
import '../../../listings/data/models/job_model.dart';
import '../../../listings/presentation/job_card_bloc/job_card_bloc.dart';
import '../../../new_listing/data/repositories/new_listings_repositories_impl.dart';
import '../../../new_listing/presentation/new_listing_bloc/new_listing_bloc.dart';
import '../../../profile/domain/usecases/get_listing_body.dart';
import '../user_listing_bloc/user_listing_bloc.dart';

class UserListingsScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const UserListingsScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  State<UserListingsScreen> createState() => _UserListingsScreenState();
}

class _UserListingsScreenState extends State<UserListingsScreen> {
  UserModel? user = Hive.box<UserModel>('user').get('userModel');

  @override
  void initState() {
    BlocProvider.of<UserListingBloc>(context).add(
      GetUserListingsJobs(isCompany: booleanIsCompany(user!.role)),
    );
    super.initState();
  }

  var list;

  @override
  Widget build(BuildContext context) {
    onSetJobsToFavourite(String id, int? isFav) async {
      BlocProvider.of<JobCardBloc>(context).add(
        ToggleFavouriteEvent(
          jobId: id,
        ),
      );
    }

    onSubmitToJob(String id) {
      BlocProvider.of<JobCardBloc>(context).add(
        ToggleApplyEvent(
          jobId: id,
        ),
      );

      if (list.length == 1) {
        BlocProvider.of<UserListingBloc>(context).add(
          const GetUserListingsJobs(isCompany: false),
        );
      }
    }

    goToJobDetails(JobModel job) {
      context.pushNamed(
        PAGES.jobDetails.screenName,
        extra: [
          job,
          booleanIsCompany(user!.role),
        ],
      );
    }

    onApplicantsScreen(String id) {
      BlocProvider.of<ApplicantsListBloc>(context).add(
        GetApplicantsListForThisJob(
          jobId: id,
        ),
      );

      context.push(PAGES.applicantsList.screenPath);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          booleanIsCompany(user!.role) ? 'Οι Αγγελίες Μου' : 'Οι Αιτήσεις Μου',
        ),
        actions: [
          booleanIsCompany(user!.role)
              ? IconButton(
                  onPressed: () async {
                    List data =
                        await NewListingsRepositoriesImpl().getAcademia();

                    await getListingBody().then((value) {
                      context.pushNamed(
                        PAGES.newListing.screenName,
                        extra: [
                          value,
                          data[0],
                          data[1],
                          data[2],
                          null,
                          null,
                          null,
                        ],
                      );
                    });
                  },
                  icon: const Icon(FontAwesomeIcons.plus),
                )
              : Container()
        ],
      ),
      body: BlocBuilder<UserListingBloc, UserListingState>(
        builder: (context, state) {
          if (state is UserListingEmpty) {
            return SafeArea(
              child: ListIsEmptyMessage(
                context: context,
                text: booleanIsCompany(user!.role)
                    ? 'Δεν έχετε δημιουργήσει καμία αγγελία.'
                    : 'Δεν έχετε κάνει αίτηση σε καμία από τις διαθέσιμες αγγελίες.',
              ),
            );
          }

          if (state is UserListingNotEmpty) {
            list = state.userListingJobs;

            return SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: BlocConsumer<JobCardBloc, JobCardState>(
                  listener: (context, state) {
                    if (state is JobCardFavourite) {
                      updateFavouriteStatus(
                        context: context,
                        list: list,
                        id: state.jobId,
                        isFav: state.isFav,
                      );
                    }
                    if (state is JobCardApply) {
                      updateApplyStatus(
                        context: context,
                        list: list,
                        id: state.jobId,
                        hasAppl: state.hasApplied,
                      );

                      list.removeWhere(
                        (element) => element.id.toString() == state.jobId,
                      );
                    }
                  },
                  builder: (context, state) {
                    return SlidableAutoCloseBehavior(
                      closeWhenOpened: true,
                      child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Slidable(
                                key: UniqueKey(),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible: DismissiblePane(
                                    onDismissed: () {
                                      BlocProvider.of<NewListingBloc>(context)
                                          .add(
                                        DeleteListingButtonPressed(
                                          id: list[index].id.toString(),
                                        ),
                                      );

                                      setState(() {
                                        list.removeAt(index);
                                      });
                                    },
                                  ),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        BlocProvider.of<NewListingBloc>(context)
                                            .add(
                                          DeleteListingButtonPressed(
                                            id: list[index].id.toString(),
                                          ),
                                        );

                                        setState(() {
                                          list.removeAt(index);
                                        });
                                      },
                                      backgroundColor: ColorsConst.errorColor,
                                      foregroundColor: Colors.white,
                                      icon: FontAwesomeIcons.trashCan,
                                      label: 'Διαγραφή',
                                    ),
                                  ],
                                ),
                                child: ResponsiveCard(
                                  list: list,
                                  index: index,
                                  toggleFav: () {
                                    onSetJobsToFavourite(
                                      list[index].id.toString(),
                                      list[index].isFavourite,
                                    );
                                  },
                                  toggleApply: () {
                                    onSubmitToJob(
                                      list[index].id.toString(),
                                    );
                                  },
                                  showDetails: () {
                                    goToJobDetails(list[index]);
                                  },
                                  context: context,
                                  isCompany: booleanIsCompany(user!.role),
                                  isMyJob: true,
                                  showApplicants: () {
                                    onApplicantsScreen(
                                      list[index].id.toString(),
                                    );
                                  },
                                  hasBottomSpacing: false,
                                ),
                              ),
                              const SizedBox(
                                height: padding,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return CustomLoading(
            ColorsConst.primaryColor,
          );
        },
      ),
    );
  }
}
