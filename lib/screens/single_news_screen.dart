import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_homework/theme.dart';
import '../classes/news.dart';

class SingleNewsScreen extends StatefulWidget {
  const SingleNewsScreen({this.news});

  final News news;

  @override
  _SingleNewsScreenState createState() => _SingleNewsScreenState(news);
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  News news = new News("", DateTime(2021), "", "", "");

  _SingleNewsScreenState(this.news) {
    this.news = news;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.secondaryHeaderColor,
      appBar: AppBar(
        title: Text('$news'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: theme.accentColor,
          ),
        ],
      ),
    );
  }
}
