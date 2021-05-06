import 'package:flutter/cupertino.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

import '../theme.dart';

class HTMLWidget extends StatefulWidget {
  final String text;

  HTMLWidget(this.text);

  @override
  _HTMLWidgetState createState() => _HTMLWidgetState(text);
}

class _HTMLWidgetState extends State<HTMLWidget> {
  final String text;

  _HTMLWidgetState(this.text);

  @override
  Widget build(BuildContext context) {
    return Html(
        data: text == "" ? "" : "<h2>Description: <\/h2>" + "<p>" + text + "<\/p>",
        style: {
          "a": Style(
            color: theme.accentColor,
          ),
          "p": Style(
            color: theme.secondaryHeaderColor,
            fontSize: FontSize.large,
          ),
          "h2": Style(
            color: theme.secondaryHeaderColor,
            fontSize: FontSize.large,
          ),
        },
        onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
          showAnimatedDialog(
            context: context.buildContext,
            barrierDismissible: true,
            barrierColor: theme.secondaryHeaderColor,
            builder: (BuildContext context) {
              return ClassicGeneralDialogWidget(
                titleText: 'Are you sure you want to navigate to this website?',
                contentText: url,
                negativeTextStyle: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 15,
                ),
                positiveTextStyle: TextStyle(
                  color: theme.accentColor,
                  fontSize: 20,
                ),
                onPositiveClick: () async {
                  if (await canLaunch(url!))
                    await launch(url);
                  else
                    // can't launch url, there is some error
                    throw "Could not launch $url";
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
        }
    );
  }
}
