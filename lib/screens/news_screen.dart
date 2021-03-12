import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/widgets/NewsCard.dart';
import '../theme.dart';
import '../data/news_data.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsData newsData = new NewsData();

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      newsData = await fetchNewsData();
      print("data loaded");

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
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
        title: Text("News"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: newsData.data.length,
              itemBuilder: (BuildContext context, int index) {
                return NewsCard(
                  news: newsData.data[index],
                );
              }),
        ),
      ),
    );
  }
}
