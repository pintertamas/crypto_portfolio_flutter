import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../theme.dart';

class DropDownButton extends StatefulWidget {
  final List<String> dropDownValues;

  const DropDownButton({
    Key? key,
    required this.dropDownValues,
  }) : super(key: key);

  @override
  _DropDownButtonState createState() => _DropDownButtonState(dropDownValues);
}

class _DropDownButtonState extends State<DropDownButton> {
  List<String> dropDownValues = [];

  _DropDownButtonState(List<String> dropDownValues) {
    this.dropDownValues = dropDownValues;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.primaryColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: theme.accentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButton<String>(
          dropdownColor: theme.accentColor,
          underline: SizedBox(),
          elevation: 10,
          focusColor: theme.primaryColor,
          value: selectedCurrency.toLowerCase(),
          iconEnabledColor: theme.primaryColor,
          items: dropDownValues.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value.toLowerCase(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Text(
                  value.toUpperCase(),
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            );
          }).toList(),
          hint: Text(
            "Choose the convert currency",
            style: TextStyle(
                color: theme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          onChanged: (value) {
            setState(() {
              selectedCurrency = value ?? "usd";
            });
          },
        ),
      ),
    );
  }
}
