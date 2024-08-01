


import 'dart:ui';

import 'package:flutter/material.dart';

mixin CommonButtonMixin{
  ///用于表示普通按钮
  Widget commonButton(String title, Color color, Function fun) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
        margin: EdgeInsets.only(left: 6, right: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(26)),
          color: color,
          // border: Border.all(
          //     color: blue ? Color(0xffE2ECF5) : Color(0xff2FA7FE),
          //     width: 1.0,
          //     style: BorderStyle.solid)
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: Color(0xffffffff),
              fontWeight: FontWeight.w400,
              fontSize: 14),
        ),
      ),
      onTap: () {
        // showInfoBean3762s.clear();
        // setState(() {});
        fun();
      },
    );
  }

}