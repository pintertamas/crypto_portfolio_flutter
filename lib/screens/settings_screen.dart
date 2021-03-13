import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/data/vs_currencies_data.dart';
import 'package:flutter_homework/widgets/dropdown_button.dart';
import '../theme.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
