
import 'package:get/get.dart';

// import '../../../model/entities/user/user_entity.dart';
import '../../../model/enums/load_status.dart';

class ProfileTabState {
  // Rxn<UserEntity> user = Rxn<UserEntity>();

  final signOutStatus = LoadStatus.initial.obs;

  ProfileTabState() {}
}
