
import 'package:get/get.dart';

import '../../../model/enums/load_status.dart';
// import '../../../repositories/auth_repository.dart';
// import '../sign_in/sign_in_view.dart';
import 'profile_tab_state.dart';

class ProfileTabLogic extends GetxController {
  final state = ProfileTabState();

  // final _authRepository = Get.find<AuthRepository>(tag: (AuthRepository).toString());

  void signOut() async {
    state.signOutStatus.value = LoadStatus.loading;

    ///Call signOut API here
    // await Future.delayed(Duration(seconds: 2));
    // _authRepository.signOut();
    // state.signOutStatus.value = LoadStatus.success;
    // Get.off(SignInPage());
  }
}
