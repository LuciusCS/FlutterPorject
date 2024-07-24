import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../utils/NavigationService.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NavigationService().navigateTo('/second', arguments: 'Hello from Home Page');
          },
          child: Text('Go to Second Page'),
        ),
      ),
    );
  }
}
