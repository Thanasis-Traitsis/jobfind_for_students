// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/usecases/calculate_font_size.dart';
import '../../../../core/utils/scaffold_message.dart';
import '../../../../core/widgets/highlight_color_button.dart';
import '../../../new_listing/data/repositories/new_listings_repositories_impl.dart';
import '../auth_bloc/auth_bloc.dart';
import '../major_id_bloc/major_id_bloc.dart';

class MajorIdScreen extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  const MajorIdScreen({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  State<MajorIdScreen> createState() => _MajorIdScreenState();
}

class _MajorIdScreenState extends State<MajorIdScreen> {
  List majorsList = [];

  List chosenMajor = [''];

  @override
  void initState() {
    getMajors();
    super.initState();
  }

  getMajors() async {
    List list = await NewListingsRepositoriesImpl().getAcademia();

    setState(() {
      majorsList = list[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    
    onSetMajorId(String id) async {
      BlocProvider.of<MajorIdBloc>(context).add(
        SetMajorId(
          majorId: id,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Επιλέξτε το πανεπιστήμιο σας',
                style: TextStyle(
                  color: ColorsConst.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              titleSpacing: 0,
              backgroundColor: ColorsConst.white,
              toolbarHeight: 60,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: padding),
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0),
                      activeColor: ColorsConst.primaryColor,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            majorsList[index]['major'],
                            style: TextStyle(
                              fontSize: calculateFontSize(
                                context,
                                mediumText,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${majorsList[index]['department']} ,',
                                style: TextStyle(
                                  fontSize: calculateFontSize(
                                    context,
                                    normalText,
                                  ),
                                ),
                              ),
                              Text(
                                majorsList[index]['university'],
                                style: TextStyle(
                                  fontSize: calculateFontSize(
                                    context,
                                    normalText,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      value: chosenMajor.contains(majorsList[index]['id']),
                      onChanged: (value) {
                        chosenMajor = [];
                        setState(() {
                          chosenMajor.add(majorsList[index]['id']);
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  );
                },
                childCount: majorsList.length,
              ),
            ),
            BlocConsumer<MajorIdBloc, MajorIdState>(
              listener: (context, state) {
                if (state is MajorIdFailure) {
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
                }

                if (state is MajorIdSuccess) {
                  BlocProvider.of<AuthBloc>(context).add(
                    AppStarted(),
                  );

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
                }
              },
              builder: (context, state) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(padding),
                    child: HighlighColorButton(
                      onPressed: () {
                        onSetMajorId(
                          chosenMajor[0].toString(),
                        );
                      },
                      text: 'Επιλογή',
                      context: context,
                      isLoading: state is MajorIdLoading ? true : false,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
