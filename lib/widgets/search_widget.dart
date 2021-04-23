import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/coin.dart';
import 'package:flutter_homework/data/supported_coins_data.dart';
import 'package:flutter_homework/theme.dart';

class SearchWidget extends StatefulWidget {
  final String tag = 'contactlist-page';

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = new TextEditingController();
  String filter = "";
  SupportedCoinData? data;

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      data = await fetchSupportedCoinsData();
      if (!mounted) return;
      print("search data loaded");

      isWaiting = false;

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Add currency',
                style: TextStyle(
                    color: theme.secondaryHeaderColor,
                    fontWeight: FontWeight.bold))),
        body: Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            Expanded(
              child: data == null
                  ? Text("Error")
                  : ListView.builder(
                      itemCount: data!.data.length,
                      itemBuilder: (context, index) {
                        // if filter is null or empty returns all data
                        return filter == null || filter == ""
                            ? ListTile(
                                title: Text(
                                  '${data!.data[index]!.name}',
                                ),
                                subtitle: Text('${data!.data[index]!.symbol}'),
                                leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                        '${data!.data[index]!.symbol.substring(0, 1)}')),
                                onTap: () =>
                                    _onTapItem(context, data!.data[index]!),
                              )
                            : '${data!.data[index]!.name}'
                                    .toLowerCase()
                                    .contains(filter.toLowerCase())
                                ? ListTile(
                                    title: Text(
                                      '${data!.data[index]!.name}',
                                    ),
                                    subtitle:
                                        Text('${data!.data[index]!.symbol}'),
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        child: Text(
                                            '${data!.data[index]!.name.substring(0, 1)}')),
                                    onTap: () =>
                                        _onTapItem(context, data!.data[index]!),
                                  )
                                : Container();
                      },
                    ),
            ),
          ],
        ));
  }

  void _onTapItem(BuildContext context, Coin coin) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Tap on " + ' - ' + coin.name)));
  }
}
