// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/theme/colors.dart';
import '../../../../../core/constants/font_size.dart';
import '../../../../../core/constants/styles.dart';
import '../../../../../core/usecases/calculate_font_size.dart';
import 'alert_dialog_item.dart';

class CustomAlertDialog extends StatefulWidget {
  final List filters;
  final String? filterText;

  const CustomAlertDialog({
    Key? key,
    required this.filters,
    required this.filterText,
  }) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  String? selectedValue;

  @override
  void initState() {
    widget.filterText != null
        ? selectedValue = widget.filterText
        : selectedValue = 'Πρόσφατα - Παλαιότερα';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop(null);
        return false;
      },
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Φίλτρα',
              style: TextStyle(
                fontSize: calculateFontSize(
                  context,
                  headerText,
                ),
                fontWeight: FontWeight.bold,
                color: ColorsConst.textColor,
              ),
            ),
            Divider(
              thickness: 1,
              color: ColorsConst.lightgreyColor,
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsConst.darkgreyColor,
                ),
                onPressed: () {
                  context.pop(null);
                },
                child: Text(
                  'Άκυρο',
                  style: TextStyle(
                    color: ColorsConst.white,
                    fontSize: calculateFontSize(
                      context,
                      mediumText,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop(selectedValue);
                },
                child: Text(
                  'Εφαρμογή',
                  style: TextStyle(
                    color: ColorsConst.white,
                    fontSize: calculateFontSize(
                      context,
                      mediumText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
        content: SizedBox(
          width: double.maxFinite,
          height: widget.filters.length * alertDialogItemHeight,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return AlertDialogItem(
                text: widget.filters[index],
                context: context,
                isChosen: widget.filters[index] == selectedValue,
                function: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              );
            },
            itemCount: widget.filters.length,
          ),
        ),
      ),
    );
  }
}
