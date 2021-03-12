import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/data/vs_currencies_data.dart';
import '../constants.dart';
import '../theme.dart';

class DropDownButton extends StatefulWidget {
  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  List<String> vsCurrencies = [];

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      vsCurrencies = await fetchVsCurrenciesData();
      print("vs_currencies data loaded");

      isWaiting = false;

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.accentColor,
      child: DropdownButton<String>(
        dropdownColor: theme.accentColor,
        focusColor: theme.secondaryHeaderColor,
        value: selectedCurrency.toLowerCase(),
        iconEnabledColor: theme.primaryColor,
        items: vsCurrencies.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value.toLowerCase(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Text(
                value.toUpperCase(),
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 20,
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
        onChanged: (String value) {
          setState(() {
            selectedCurrency = value;
          });
        },
      ),
    );
  }
}
