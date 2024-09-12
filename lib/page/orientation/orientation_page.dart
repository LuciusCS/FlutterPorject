import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../common/base/app_dimens.dart';
import '../../common/services/setting_service.dart';
import '../../common/theme/my_theme.dart';
import '../../common/theme/theme_extensions/header_container_theme_data.dart';
import '../../common/translations/localization_service.dart';
import '../../common/translations/strings_enum.dart';

// import '../../../common/app_dimens.dart';
// import '../../../generated/l10n.dart';
// import '../../../services/setting_service.dart';
// import '../../widgets/appbar/app_bar_widget.dart';

/**
 * 用于切换水平屏幕和垂直屏幕
 *
 */
class OrientationPage extends StatefulWidget {
  const OrientationPage({Key? key}) : super(key: key);

  @override
  _OrientationPageState createState() => _OrientationPageState();
}

class _OrientationPageState extends State<OrientationPage> {
  final settingService = Get.find<SettingService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("水平竖直屏幕切换"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildVerticalLayout()
              : _buildHorizontalLayout();
        },
      ),
    );
  }

  Widget _buildVerticalLayout() {
    return Column(
      children: <Widget>[
        PeopleIconView(),
        Expanded(
          child: ItemListView(),
        )
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
              child: PeopleIconView()
          ),
          Expanded(
            child: ItemListView(),
          ),
        ],
      ),
    );
  }




}


class PeopleIconView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Icon(
        Icons.people_outline,
        size: 80.0,
      ),
    );
  }
}

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(30, (n) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Some text',
            style: TextStyle(fontSize: 25.0),
          ),
        );
      }),
    );
  }
}