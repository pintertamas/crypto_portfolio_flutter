import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/data/vs_currencies_data.dart';

import '../constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: FloatingActionButton(
          onPressed: () {
            print(vsCurrencies == null ? 1 : vsCurrencies);
            setState(() {
              selectedCurrency == currenciesList[0]
                  ? selectedCurrency = currenciesList[1]
                  : selectedCurrency = currenciesList[0];
            });
          },
        ),
      ),
    );
  }
}
