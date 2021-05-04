import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/classes/coin_list_element.dart';
import 'package:flutter_homework/data/supported_coins_data.dart';
import 'package:flutter_homework/theme.dart';
import 'package:flutter_homework/widgets/list_tile_widget.dart';

class SearchScreen extends StatefulWidget {
  final Map<String, double> portfolio;

  SearchScreen(this.portfolio);

  @override
  _SearchScreenState createState() => _SearchScreenState(portfolio);
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  String filter = "";
  late Future<SupportedCoinData?> coinData;
  Map<String, double> portfolio;

  _SearchScreenState(this.portfolio);

  Future<SupportedCoinData?> getData() async {
    try {
      final data = await fetchSupportedCoinsData();
      if (!mounted) return data;
      print("supported coin data loaded");
      EasyLoading.dismiss();
      return data;
    } catch (e) {
      print(e);
      print("exception");
      EasyLoading.dismiss();
      return null;
    }
  }

  @override
  initState() {
    super.initState();
    coinData = getData();
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
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
          title: Text('Add currency',
              style: TextStyle(
                  color: theme.secondaryHeaderColor,
                  fontWeight: FontWeight.bold))),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: theme.primaryColor,
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<SupportedCoinData?>(
              future: coinData,
              builder: (context, snapshot) {
                if (snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data!.data;
                  return ListView.builder(
                    itemCount: filter == "" ? 0 : data.length,
                    itemBuilder: (context, index) {
                      //print(data.keys.toList()[index]);
                      CoinListElement coin = data[data.keys.toList()[index]]!;
                      return filter == ""
                          ? Center(
                              child: Text(""),
                            )
                          : '${coin.name}'
                                  .toLowerCase()
                                  .contains(filter.toLowerCase())
                              ? ListTileWidget(coin, portfolio)
                              : Container();
                    },
                  );
                } else
                  return Text(
                    '${EasyLoading.show(status: 'Loading...')}',
                    style: TextStyle(
                      fontSize: 0,
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
