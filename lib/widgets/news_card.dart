import 'package:flutter/material.dart';
import 'package:flutter_homework/classes/functions.dart';
import '../classes/news.dart';
import '../theme.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theme.primaryColor,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Column(
          children: [
            Text(
              news.user == null || news.user == 'null'
                  ? 'Unknown user'
                  : '${news.user}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: theme.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                  child: Text(
                    '${news.description}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: theme.secondaryHeaderColor,
                    ),
                  ),
                ),
                Text(
                  '${passedTime(news.createdAt!)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: theme.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}