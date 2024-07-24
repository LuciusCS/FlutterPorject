
import 'package:flutter/material.dart';
class SecondPage extends StatelessWidget {
  final String? arguments;

  SecondPage({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: Text(arguments ?? 'No Data'),
      ),
    );
  }
}