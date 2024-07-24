import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../model/entities/user/user_entity.dart';

class AppService extends GetxService {
  // Theme
  // final Rx<UserEntity?> user = null.obs;

  Future<AppService> init() async {
    return this;
  }
}
