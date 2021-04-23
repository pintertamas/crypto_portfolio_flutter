import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_homework/classes/coin.dart';
import 'package:flutter_homework/data/supported_coins_data.dart';
import 'package:flutter_homework/theme.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = new TextEditingController();
  String filter = "";
  late Future<SupportedCoinData> data;

  Future<SupportedCoinData> getData() async {
    try {
      final data = await fetchSupportedCoinsData();
      if (!mounted) return data;
      print("supported coin data loaded");
      EasyLoading.dismiss();
      return SupportedCoinData();
    } catch (e) {
      print(e);
      return SupportedCoinData();
    }
  }

  @override
  initState() {
    super.initState();
    data = getData();
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
            child: FutureBuilder<SupportedCoinData>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.done) {
                  final data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (context, index) {
                      final Coin coin = data.data[index]!;
                      // if filter is null or empty returns all data
                      return filter == ""
                          ? ListTile(
                              title: Text(
                                '$coin',
                              ),
                              subtitle: Text('${coin.symbol}'),
                              leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child:
                                      Text('${coin.symbol.substring(0, 1)}')),
                              onTap: () => _onTapItem(context, coin),
                            )
                          : '${coin.name}'
                                  .toLowerCase()
                                  .contains(filter.toLowerCase())
                              ? ListTile(
                                  title: Text(
                                    '${coin.name}',
                                  ),
                                  subtitle: Text('${coin.symbol}'),
                                  leading: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child:
                                          Text('${coin.name.substring(0, 1)}')),
                                  onTap: () => _onTapItem(context, coin),
                                )
                              : Container();
                    },
                  );
                } else
                  return Center(
                    child: Text("Loading or else"),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onTapItem(BuildContext context, Coin coin) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Tap on " + ' - ' + coin.name)));
  }
}

/*ListView.builder(
                        itemCount: data!.data.length,
                        itemBuilder: (context, index) {
                          final Coin coin = data!.data[index]!;
                          // if filter is null or empty returns all data
                          return filter == ""
                              ? ListTile(
                                  title: Text(
                                    '$coin',
                                  ),
                                  subtitle: Text('${coin.symbol}'),
                                  leading: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child:
                                          Text('${coin.symbol.substring(0, 1)}')),
                                  onTap: () => _onTapItem(context, coin),
                                )
                              : '${coin.name}'
                                      .toLowerCase()
                                      .contains(filter.toLowerCase())
                                  ? ListTile(
                                      title: Text(
                                        '${coin.name}',
                                      ),
                                      subtitle: Text('${coin.symbol}'),
                                      leading: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          child: Text(
                                              '${coin.name.substring(0, 1)}')),
                                      onTap: () => _onTapItem(context, coin),
                                    )
                                  : Container();
                        },
                      ),*/
