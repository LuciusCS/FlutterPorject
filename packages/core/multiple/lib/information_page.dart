
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class InformationPage extends StatefulWidget {
  static const String sName = "information_page";



  InformationPage( {Key? key}) : super(key: key);

  @override
  InformationState createState() => InformationState();
}

class InformationState extends State<InformationPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
            "页面测试信息",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Stack(
            children: [

              Text("测试信息"),
            ],
          ),
        )));
  }

}
