// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_bloc_ihu/core/utils/routes_utils.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/errors/error_model.dart';
import '../../../../core/errors/error_text.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../../core/widgets/custom_adaptive_dialog.dart';
import '../../../../core/widgets/highlight_color_button.dart';
import '../../../listings/domain/usecases/transform_employment_type.dart';
import '../../../profile/domain/usecases/is_expanded_textfield.dart';
import '../../../profile/domain/usecases/translate_listing_body.dart';
import '../../../signup/presentation/widgets/custom_signup_textfield.dart';
import '../../domain/usecases/academia_listings.dart';
import '../../domain/usecases/translate_employment_type.dart';
import '../new_listing_bloc/new_listing_bloc.dart';
import '../widgets/custom_expansion_tile.dart';
import '../widgets/dropdown_button_selection.dart';

class NewListingScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final List listingBody;
  final List universities;
  final Map departments;
  final Map majors;
  final Map? values;
  final List? majorValues;
  final String? jobId;

  const NewListingScreen({
    Key? key,
    required this.scaffoldMessengerKey,
    required this.listingBody,
    required this.universities,
    required this.departments,
    required this.majors,
    this.values,
    this.majorValues,
    required this.jobId,
  }) : super(key: key);

  @override
  State<NewListingScreen> createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  List<TextEditingController> textControllerList = [];
  List uni = [];

  List dep = [];
  List chosenDep = [];

  List maj = [];
  List chosenMajors = [];

  ErrorModel? errors;

  var employmentType = [
    'Ημιαπασχόληση',
    'Πλήρης Απασχόληση',
    'Πρακτική Άσκηση',
  ];

  String? selectedValue;

  @override
  void initState() {
    for (var i = 0; i < widget.listingBody.length - 1; i++) {
      textControllerList.add(TextEditingController());

      textControllerList[i].text = widget.values?[widget.listingBody[i]] == null
          ? ''
          : widget.values![widget.listingBody[i]].toString();
    }

    selectedValue = widget.values?['employment_type'] != null
        ? transformEmploymentType(widget.values?['employment_type'])
        : null;

    if (widget.majorValues != null) {
      for (var i = 0; i < widget.majorValues![0].length; i++) {
        uni.add(widget.majorValues![0][i]);

        for (var j = 0; j < widget.universities.length; j++) {
          if (widget.majorValues![0][i] == widget.universities[j]) {
            addAcademiaListings(
              parentList: widget.universities,
              childList: widget.departments,
              returnList: dep,
              value: j,
            );
          }
        }
      }

      for (var i = 0; i < widget.majorValues![1].length; i++) {
        chosenDep.add(widget.majorValues![1][i]);

        for (var j = 0; j < dep.length; j++) {
          if (widget.majorValues![1][i] == dep[j]) {
            addAcademiaListings(
              parentList: dep,
              childList: widget.majors,
              returnList: maj,
              value: j,
              isMajor: true,
            );
          }
        }
      }
      for (var i = 0; i < widget.majorValues![2].length; i++) {
        chosenMajors.add(widget.majorValues![2][i]);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    onCreateListingButtonPressed() async {
      Map body = {};

      var encodedMajors = json.encode(chosenMajors);

      for (var i = 0; i < widget.listingBody.length; i++) {
        if (widget.listingBody[i] == 'employment_type') {
          textControllerList[i].text = translateEmploymentType(selectedValue);
          body[widget.listingBody[i]] = textControllerList[i].text;
        } else if (widget.listingBody[i] == 'major_ids') {
          body[widget.listingBody[i]] = encodedMajors;
        } else {
          body[widget.listingBody[i]] = textControllerList[i].text;
        }
      }

      BlocProvider.of<NewListingBloc>(context).add(
        CreateListingButtonPressed(
          body: body,
        ),
      );
    }

    onUpdateListingButtonPressed() async {
      Map body = {};

      var encodedMajors = json.encode(chosenMajors);

      for (var i = 0; i < widget.listingBody.length; i++) {
        if (widget.listingBody[i] == 'employment_type') {
          textControllerList[i].text = translateEmploymentType(selectedValue);
          body[widget.listingBody[i]] = textControllerList[i].text;
        } else if (widget.listingBody[i] == 'major_ids') {
          body[widget.listingBody[i]] = encodedMajors;
        } else {
          body[widget.listingBody[i]] = textControllerList[i].text;
        }
      }

      BlocProvider.of<NewListingBloc>(context).add(
        UpdateListingButtonPressed(
          body: body,
          id: widget.jobId!,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.values != null ? 'Ενημέρωση Αγγελίας ' : 'Νέα Αγγελία',
        ),
        actions: [
          widget.values != null
              ? IconButton(
                  onPressed: () async {
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) {
                        return CustomAdaptiveDialog(
                          context: context,
                          heading: 'Διαγραφή',
                          text:
                              'Είστε σίγουρος ότι θέλετε να διαγράψετε την αγγελία.',
                          onPressed: () {
                            BlocProvider.of<NewListingBloc>(context).add(
                              DeleteListingButtonPressed(
                                id: widget.jobId!,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.trashCan),
                )
              : Container()
        ],
      ),
      body: SafeArea(
        child: BlocListener<NewListingBloc, NewListingState>(
          listener: (context, state) {
            if (state is NewListingFailure) {
              widget.scaffoldMessengerKey.currentState?.showSnackBar(
                ScaffoldMessage(
                  context: context,
                  message: state.message,
                  onTap: () {
                    widget.scaffoldMessengerKey.currentState
                        ?.hideCurrentSnackBar();
                  },
                ),
              );

              setState(() {
                errors = state.errors;
              });
            }

            if (state is NewListingSuccess) {
              widget.scaffoldMessengerKey.currentState?.showSnackBar(
                ScaffoldMessage(
                  context: context,
                  message: state.message,
                  onTap: () {
                    widget.scaffoldMessengerKey.currentState
                        ?.hideCurrentSnackBar();
                  },
                ),
              );

              widget.values != null
                  ? context.go(PAGES.profile.screenPath)
                  : context.pop();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(padding),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return widget.listingBody[index] == 'employment_type'
                          ? DropdownButtonSelection(
                              heading: translateListingBody(
                                  widget.listingBody[index]),
                              error: widget.listingBody[index],
                              errorModel: errors,
                              list: employmentType,
                              selectedValue: selectedValue,
                              context: context,
                              onPressed: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              },
                            )
                          : widget.listingBody[index] == 'major_ids'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: 30,
                                      child: Text(
                                        translateListingBody(
                                            widget.listingBody[index]),
                                        style: TextStyle(
                                          fontSize: calculateFontSize(
                                              context, normalText),
                                          fontWeight: FontWeight.bold,
                                          color: ColorsConst.primaryColor,
                                        ),
                                      ),
                                    ),
                                    CustomExpansionTile(
                                      context: context,
                                      heading: translateListingBody(
                                          widget.listingBody[index]),
                                      list: widget.universities,
                                      myList: uni,
                                      onChanged: (value) {
                                        setState(() {
                                          if (uni.contains(
                                            widget.universities[value],
                                          )) {
                                            uni.remove(
                                              widget.universities[value],
                                            );

                                            for (var i = 0;
                                                i <
                                                    widget
                                                        .departments[
                                                            widget.universities[
                                                                value]]
                                                        .length;
                                                i++) {
                                              dep.remove(widget.departments[
                                                      widget
                                                          .universities[value]]
                                                  [i]['name']);

                                              if (chosenDep.contains(
                                                  widget.departments[widget
                                                          .universities[value]]
                                                      [i]['name'])) {
                                                chosenDep.remove(
                                                    widget.departments[
                                                        widget.universities[
                                                            value]][i]['name']);
                                              }

                                              for (var j = 0;
                                                  j <
                                                      widget
                                                          .departments[widget
                                                                  .universities[
                                                              value]][i]['majors']
                                                          .length;
                                                  j++) {
                                                maj.removeWhere((department) =>
                                                    department["name"] ==
                                                    widget.departments[
                                                            widget.universities[
                                                                value]][i]
                                                        ['majors'][j]['name']);

                                                chosenMajors.removeWhere((major) =>
                                                    major ==
                                                    widget.departments[
                                                            widget.universities[
                                                                value]][i]
                                                        ['majors'][j]['id']);
                                              }
                                            }
                                          } else {
                                            uni.add(
                                              widget.universities[value],
                                            );

                                            addAcademiaListings(
                                              parentList: widget.universities,
                                              childList: widget.departments,
                                              returnList: dep,
                                              value: value,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    CustomExpansionTile(
                                      context: context,
                                      heading: 'Τμήματα',
                                      list: dep,
                                      myList: chosenDep,
                                      onChanged: (value) {
                                        setState(() {
                                          if (chosenDep.contains(
                                            dep[value],
                                          )) {
                                            chosenDep.remove(
                                              dep[value],
                                            );

                                            for (var i = 0;
                                                i <
                                                    widget.majors[dep[value]]
                                                        .length;
                                                i++) {
                                              if (chosenMajors.contains(
                                                  widget.majors[dep[value]][i]
                                                      ['id'])) {
                                                chosenMajors.remove(
                                                    widget.majors[dep[value]][i]
                                                        ['id']);
                                              }
                                            }

                                            removeAcademiaListings(
                                              parentList: dep,
                                              childList: widget.majors,
                                              returnList: maj,
                                              value: value,
                                              isMajor: true,
                                            );
                                          } else {
                                            chosenDep.add(
                                              dep[value],
                                            );

                                            addAcademiaListings(
                                              parentList: dep,
                                              childList: widget.majors,
                                              returnList: maj,
                                              value: value,
                                              isMajor: true,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    CustomExpansionTile(
                                      isMajor: true,
                                      context: context,
                                      heading: 'Σχολές',
                                      list: maj,
                                      myList: chosenMajors,
                                      onChanged: (value) {
                                        setState(() {
                                          if (chosenMajors.contains(
                                            maj[value]['id'],
                                          )) {
                                            chosenMajors.remove(
                                              maj[value]['id'],
                                            );
                                          } else {
                                            chosenMajors.add(
                                              maj[value]['id'],
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    ErrorText(
                                      context: context,
                                      error: widget.listingBody[index],
                                      errorModel: errors,
                                    ),
                                  ],
                                )
                              : CustomSignupTextfield(
                                  controller: textControllerList[index],
                                  text: translateListingBody(
                                      widget.listingBody[index]),
                                  error: widget.listingBody[index],
                                  errorModel: errors,
                                  context: context,
                                  unlimitedLines: isExpandedTextfield(
                                      widget.listingBody[index]),
                                  expand: isExpandedTextfield(
                                      widget.listingBody[index]),
                                  acceptOnlyNumbers:
                                      widget.listingBody[index] == 'experience',
                                );
                    },
                    itemCount: widget.listingBody.length,
                  ),
                ),
                BlocBuilder<NewListingBloc, NewListingState>(
                  builder: (context, state) {
                    return HighlighColorButton(
                      onPressed: () {
                        widget.values != null
                            ? onUpdateListingButtonPressed()
                            : onCreateListingButtonPressed();
                      },
                      text: widget.values != null ? 'Ενημέρωση' : 'Δημιουργία',
                      context: context,
                      isLoading: state is NewListingLoading ? true : false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
