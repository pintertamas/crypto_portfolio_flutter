import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/data/vs_currencies_data.dart';
import 'package:flutter_homework/widgets/dropdown_button.dart';
import 'package:flutter_homework/screens/search_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';

class SettingsScreen extends StatefulWidget {
  final Map<String, double> portfolio;

  const SettingsScreen({Key? key, required this.portfolio}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState(portfolio);
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, double> portfolio;

  _SettingsScreenState(this.portfolio);

  _deletePortfolio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      portfolio.clear();
      prefs.clear();
    });
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
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
                          Text(
                            'Convert currency\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: theme.secondaryHeaderColor,
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
                                      dropDownValues: snapshot.data!,
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
              ),
              Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 10,
                  color: theme.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(portfolio),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            'Add currency\n',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: theme.secondaryHeaderColor,
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.plus,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 10,
                color: theme.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      showAnimatedDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ClassicGeneralDialogWidget(
                            titleText: 'Are you sure you want to delete your portfolio?',
                            negativeTextStyle: TextStyle(
                              color: theme.primaryColor,
                              fontSize: 15,
                            ),
                            positiveTextStyle: TextStyle(
                              color: theme.accentColor,
                              fontSize: 20,
                            ),
                            onPositiveClick: () {
                              _deletePortfolio();
                              Navigator.of(context).pop();
                            },
                            onNegativeClick: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        animationType: DialogTransitionType.size,
                        curve: Curves.fastOutSlowIn,
                        duration: Duration(seconds: 1),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          'Delete portfolio\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: theme.secondaryHeaderColor,
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.trash,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
