import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../common/base/app_dimens.dart';
import '../../common/services/setting_service.dart';
import '../../common/theme/my_theme.dart';
import '../../common/theme/theme_extensions/header_container_theme_data.dart';
import '../../common/translations/localization_service.dart';
import '../../common/translations/strings_enum.dart';
import 'history/mmkv_page.dart';

// import '../../../common/app_dimens.dart';
// import '../../../generated/l10n.dart';
// import '../../../services/setting_service.dart';
// import '../../widgets/appbar/app_bar_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final settingService = Get.find<SettingService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("历史记录"),
      ),
      body: Container(
        padding: EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: (){
                Get.to(() => MMKVPage());

              },
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 10,bottom: 10,right: 10),
                child: Text("MMKV"),
              ),
            ),

            InkWell(
              onTap: (){

              },
              child: Container(
                padding: EdgeInsets.only(top: 20,left: 10,bottom: 10,right: 10),
                child: Text("读取数据"),
              ),
            )
          ],
        ),
      ),
    );
  }





}
