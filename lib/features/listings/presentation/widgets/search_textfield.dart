// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/theme/colors.dart';
import '../../../../core/constants/containers.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/usecases/calculate_font_size.dart';

class SearchTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function function;

  const SearchTextfield({
    Key? key,
    required this.controller,
    required this.function,
  }) : super(key: key);

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: calculateFontSize(
        context,
        headerRowSize + 5,
      ),
      child: TextField(
        controller: widget.controller,
        style: TextStyle(
          color: ColorsConst.textColor,
          fontSize: calculateFontSize(
            context,
            mediumText,
          ),
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: gap / 4,
          ),
          prefixIcon: IconButton(
            icon: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: ColorsConst.darkgreyColor,
              size: calculateFontSize(
                context,
                25,
              ),
            ),
            onPressed: () {
              widget.function();
            },
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    FontAwesomeIcons.solidCircleXmark,
                    color: ColorsConst.lightgreyColor,
                    size: calculateFontSize(
                      context,
                      25,
                    ),
                  ),
                  onPressed: () {
                    widget.controller.clear();
                  },
                )
              : null,
          label: Text(
            'Αναζήτηση για ...',
            style: TextStyle(
              fontSize: calculateFontSize(
                context,
                mediumText,
              ),
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
            fontSize: calculateFontSize(
              context,
              mediumText,
            ),
          ),
          filled: true,
          fillColor: ColorsConst.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: ColorsConst.darkgreyColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: ColorsConst.darkgreyColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
