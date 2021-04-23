import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
        child: Text(
          news == null
              ? '${EasyLoading.show(status: 'Loading...')}'
              : '${news.description}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            color: theme.secondaryHeaderColor,
          ),
        ),
      ),
    );
  }
}
