import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/utils/routes_utils.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/usecases/boolean_is_company.dart';
import '../../data/models/job_model.dart';
import '../../data/repositories/job_repositories_impl.dart';
import '../../domain/usecases/get_filter_list.dart';
import '../../domain/usecases/translate_filter_category.dart';
import '../job_bloc/job_bloc.dart';
import '../job_card_bloc/job_card_bloc.dart';
import '../widgets/alert_dialog/custom_alert_dialog.dart';
import '../widgets/bottom_loading_indicator.dart';
import '../widgets/center_empty_text.dart';
import '../widgets/info_text_for_textfield.dart';
import '../widgets/job_list.dart';
import '../widgets/search_and_filter_appbar.dart';

class JobListingScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const JobListingScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  State<JobListingScreen> createState() => _JobListingScreenState();
}

class _JobListingScreenState extends State<JobListingScreen> {
  final controller = ScrollController();
  final TextEditingController searchController = TextEditingController();

  var list;
  bool canFethMore = true;
  bool isLoading = false;
  bool showInfo = false;
  int pageNumber = 1;

  List filterList = [];
  String chosenFilter = 'Πρόσφατα - Παλαιότερα';

  String urlFilter = '';

  @override
  void initState() {
    super.initState();

    getFilters();

    controller.addListener(
      () {
        if (list.length >= 15 && canFethMore) {
          if (controller.position.maxScrollExtent == controller.offset &&
              !isLoading) {
            fetchMore().then((_) {
              setState(() {
                isLoading = false;
              });
            });
          }
        }
      },
    );
  }

  Future fetchMore() async {
    setState(() {
      pageNumber++;
      isLoading = true;
    });

    await JobRepositoriesImpl()
        .fetchMoreJobs(pageNumber, urlFilter)
        .then((value) {
      setState(
        () {
          list.addAll(value[0]);
          if (value[1] != null) {
            canFethMore = true;
          } else {
            canFethMore = false;
          }
        },
      );
    });
  }

  Future getFilters() async {
    var result = await rootBundle.loadString('assets/filters.json');

    filterList = jsonDecode(result)['filters'];
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Hive.box<UserModel>('user').get('userModel');

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

    onSearchTextField(String text) {
      if (text.length == 0) {
        return;
      }
      if (text.length > 2) {
        setState(() {
          urlFilter = 'search=$text&';
          showInfo = false;
        });
        BlocProvider.of<JobBloc>(context).add(
          GetSearchListing(
            searchText: text,
          ),
        );
      } else {
        setState(() {
          showInfo = true;
        });
      }
    }

    onFilterListing(String text) {
      var translatedText = translateFilterCategory(text);

      setState(() {
        if (text == 'recent') {
          urlFilter = '';
        } else if (text == 'by_user_major') {
          urlFilter = 'major_id=$translatedText&';
        } else {
          urlFilter = 'filter=$translatedText&';
        }
      });

      BlocProvider.of<JobBloc>(context).add(
        GetFilteredListing(
          filterText: text,
        ),
      );
    }

    onFilterRequest() {
      setState(() {
        showInfo = false;
        searchController.clear();
      });
      BlocProvider.of<JobBloc>(context).add(
        GetRecentJobs(),
      );
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          color: ColorsConst.white,
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                onFilterRequest();
              },
              child: user!.role == 'user' || user.role == 'old_student'
                  ? user.complete!['profile'] && user.complete!['submission']
                      ? CustomScrollView(
                          controller: controller,
                          slivers: [
                            SearchAndFilterAppbar(
                              context: context,
                              function: (String value) {
                                onSearchTextField(value);
                              },
                              searchController: searchController,
                              onTap: () {
                                var filters =
                                    getFilterList(user!.role!, filterList);

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomAlertDialog(
                                      filters: filters,
                                      filterText: chosenFilter,
                                    );
                                  },
                                ).then((value) {
                                  if (value != null && value != chosenFilter) {
                                    onFilterListing(value);

                                    setState(() {
                                      pageNumber = 1;
                                      chosenFilter = value.toString();
                                    });
                                  }
                                });
                              },
                            ),
                            InfoTextForTextfield(
                              context: context,
                              isHidden: showInfo,
                              text: searchController.text,
                              showResultText: searchController.text.isNotEmpty,
                              function: onFilterRequest,
                            ),
                            BlocBuilder<JobBloc, JobState>(
                              builder: (context, state) {
                                if (state is JobsRecent) {
                                  list = state.recentJobs;

                                  return state.recentJobs.isNotEmpty
                                      ? JobList(
                                          list: list,
                                          stateList: state.recentJobs,
                                          favFunction: onSetJobsToFavourite,
                                          submitFunction: onSubmitToJob,
                                          detailsFunction: goToJobDetails,
                                          isCompany:
                                              booleanIsCompany(user.role),
                                        )
                                      : CenterEmptyText(
                                          context: context,
                                          text:
                                              'Δεν υπάρχει καμία διαθέσιμη αγγελία.',
                                        );
                                } else if (state is JobsFiltered) {
                                  list = state.filteredJobs;

                                  return state.filteredJobs.isNotEmpty
                                      ? JobList(
                                          list: list,
                                          stateList: state.filteredJobs,
                                          favFunction: onSetJobsToFavourite,
                                          submitFunction: onSubmitToJob,
                                          detailsFunction: goToJobDetails,
                                          isCompany:
                                              booleanIsCompany(user.role),
                                        )
                                      : CenterEmptyText(
                                          context: context,
                                          text:
                                              'Δε βρέθηκε καμία αγγελία με τα στοιχεία που δώσατε.',
                                          refreshButton: true,
                                        );
                                } else {
                                  return SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: 150,
                                      child: Center(
                                        child: Transform.scale(
                                          scale: 1.4,
                                          child: CustomLoading(
                                            ColorsConst.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            BottomLoadingIndicator(
                              isLoading: isLoading,
                              canFethMore: canFethMore,
                            ),
                          ],
                        )
                      : CustomScrollView(
                          controller: controller,
                          slivers: [
                            SearchAndFilterAppbar(
                              context: context,
                              function: (String value) {
                                onSearchTextField(value);
                              },
                              searchController: searchController,
                              onTap: () {
                                var filters =
                                    getFilterList(user.role!, filterList);

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomAlertDialog(
                                      filters: filters,
                                      filterText: chosenFilter,
                                    );
                                  },
                                ).then((value) {
                                  if (value != null && value != chosenFilter) {
                                    onFilterListing(value);

                                    setState(() {
                                      pageNumber = 1;
                                      chosenFilter = value.toString();
                                    });
                                  }
                                });
                              },
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                margin: const EdgeInsets.all(padding),
                                padding: const EdgeInsets.all(padding),
                                decoration: BoxDecoration(
                                  color: ColorsConst.lightgreyColor
                                      .withOpacity(.2),
                                  border: Border.all(
                                    color: ColorsConst.lightgreyColor,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(borderRadius),
                                  ),
                                ),
                                child: Text(
                                  'Οι αγγελίες δεν είναι διαθέσιμες για το αυτόν τον λογαριασμό προς το παρόν. Παρακαλώ μεταβείτε στη σελίδα του προφίλ για την ολοκλήρωση του λογαριασμού σας.',
                                  style: TextStyle(
                                    color: ColorsConst.textColor,
                                    fontSize: calculateFontSize(
                                      context,
                                      normalText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                  : CustomScrollView(
                      controller: controller,
                      slivers: [
                        SearchAndFilterAppbar(
                          context: context,
                          function: (String value) {
                            onSearchTextField(value);
                          },
                          searchController: searchController,
                          onTap: () {
                            var filters =
                                getFilterList(user.role!, filterList);

                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlertDialog(
                                  filters: filters,
                                  filterText: chosenFilter,
                                );
                              },
                            ).then((value) {
                              if (value != null && value != chosenFilter) {
                                onFilterListing(value);

                                setState(() {
                                  pageNumber = 1;
                                  chosenFilter = value.toString();
                                });
                              }
                            });
                          },
                        ),
                        InfoTextForTextfield(
                          context: context,
                          isHidden: showInfo,
                          text: searchController.text,
                          showResultText: searchController.text.isNotEmpty,
                          function: onFilterRequest,
                        ),
                        BlocBuilder<JobBloc, JobState>(
                          builder: (context, state) {
                            if (state is JobsRecent) {
                              list = state.recentJobs;

                              return state.recentJobs.isNotEmpty
                                  ? JobList(
                                      list: list,
                                      stateList: state.recentJobs,
                                      favFunction: onSetJobsToFavourite,
                                      submitFunction: onSubmitToJob,
                                      detailsFunction: goToJobDetails,
                                      isCompany: booleanIsCompany(user.role),
                                    )
                                  : CenterEmptyText(
                                      context: context,
                                      text:
                                          'Δεν υπάρχει καμία διαθέσιμη αγγελία.',
                                    );
                            } else if (state is JobsFiltered) {
                              list = state.filteredJobs;

                              return state.filteredJobs.isNotEmpty
                                  ? JobList(
                                      list: list,
                                      stateList: state.filteredJobs,
                                      favFunction: onSetJobsToFavourite,
                                      submitFunction: onSubmitToJob,
                                      detailsFunction: goToJobDetails,
                                      isCompany: booleanIsCompany(user.role),
                                    )
                                  : CenterEmptyText(
                                      context: context,
                                      text:
                                          'Δε βρέθηκε καμία αγγελία με τα στοιχεία που δώσατε.',
                                      refreshButton: true,
                                    );
                            } else {
                              return SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 150,
                                  child: Center(
                                    child: Transform.scale(
                                      scale: 1.4,
                                      child: CustomLoading(
                                        ColorsConst.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        BottomLoadingIndicator(
                          isLoading: isLoading,
                          canFethMore: canFethMore,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
