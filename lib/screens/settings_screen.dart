import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/data/device_data.dart';
import 'package:flutter_homework/data/supported_coins_data.dart';
import 'package:flutter_homework/data/vs_currencies_data.dart';
import 'package:flutter_homework/widgets/dropdown_button.dart';
import '../theme.dart';

class SettingsScreen extends StatefulWidget {
  final Map<String, double> portfolio;

  const SettingsScreen({Key key, this.portfolio}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState(portfolio);
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, double> portfolio;

  _SettingsScreenState(Map<String, double> portfolio) {
    this.portfolio = portfolio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 10,
              color: theme.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 10,
              color: theme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
                          child: Text(
                            'Convert currency',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: theme.secondaryHeaderColor,
                            ),
                          ),
                        ),
                        FutureBuilder<List<String>>(
                          future: fetchVsCurrenciesData(), // async work
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Text(
                                  '${EasyLoading.show(status: 'Loading...')}',
                                  style: TextStyle(
                                    fontSize: 0,
                                  ),
                                );
                              default:
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                else {
                                  EasyLoading.dismiss();
                                  return DropDownButton(
                                    dropDownValues: snapshot.data,
                                  );
                                }
                            }
                          },
                        )
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 10,
              color: theme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
                        child: Text(
                          'Add currency',
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.secondaryHeaderColor,
                          ),
                        ),
                      ),
                      FutureBuilder<SupportedCoinData>(
                        future: fetchSupportedCoinsData(), // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<SupportedCoinData> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Text(
                                '${EasyLoading.show(status: 'Loading...')}',
                                style: TextStyle(
                                  fontSize: 0,
                                ),
                              );
                            default:
                              if (snapshot.hasError)
                                return Text('Error: ${snapshot.error}');
                              else {
                                EasyLoading.dismiss();
                                return DropDownButton(
                                  dropDownValues:
                                      convertToNamesOnly(snapshot.data),
                                );
                              }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),*/
