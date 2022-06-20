import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TutorialDetailScreen extends StatelessWidget {
  const TutorialDetailScreen({Key? key, required this.title, required this.htmlData}) : super(key: key);

  final String title;
  final String htmlData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(title),),
        body: Html(
          data: htmlData,
        ),
      ),
    );
  }
}
