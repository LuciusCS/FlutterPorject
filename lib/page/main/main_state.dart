import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../function/function_list_page.dart';
import '../orientation/auto_change_page.dart';
import '../orientation/orientation_page.dart';
import '../tab_home/home_tab_view.dart';
import '../tab_profile/profile_tab_view.dart';

// import '../tab_home/home_tab_view.dart';
// import '../tab_profile/profile_tab_view.dart';

class MainState {
  ///Select index- responsive
  late RxInt selectedIndex;

  ///PageView page
  late List<Widget> pageList;
  late PageController pageController;

  MainState() {
    //Initialize index
    selectedIndex = 0.obs;
    //PageView page
    pageList = [
      HomeTabPage(),
      FunctionListPage(),
      OrientationPage(),
      AutoChangePage(),
      ProfileTabPage(),
    ];
    //Page controller
    pageController = PageController();
  }
}
