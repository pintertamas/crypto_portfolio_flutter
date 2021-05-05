import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class TxButton extends StatelessWidget {
  final String text;

  final void Function() onTap; //your function expects a context

  const TxButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FittedBox(
        child: Card(
          color: theme.accentColor,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
              child: Text(
                text,
                style: TextStyle(
                  color: theme.primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
