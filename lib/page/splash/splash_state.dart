
import 'package:get/get.dart';

import '../../../model/enums/load_status.dart';

class SplashState {
  Rx<LoadStatus> loginState = LoadStatus.initial.obs;

  SplashState() {
    ///Initialize variables
  }
}
