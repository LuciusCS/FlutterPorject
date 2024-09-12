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

/***
 * 用于表示根据屏幕尺寸，对布局进行切换
 */
class AutoChangePage extends StatefulWidget {
  const AutoChangePage({Key? key}) : super(key: key);

  @override
  _AutoChangePageState createState() => _AutoChangePageState();
}

class _AutoChangePageState extends State<AutoChangePage> {
  final settingService = Get.find<SettingService>();
  var selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("根据屏幕尺寸切换布局"),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (MediaQuery.of(context).size.width > 480) {
          return Row(children: <Widget>[
            Expanded(
              child: ListWidget((value) {
                setState(() {selectedValue = value;});
              }),
            ),
            Expanded(child: DetailWidget(selectedValue)),
          ]);

        } else {
          return ListWidget((value) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(),
                  body: DetailWidget(value),
                );
              },
            ));

          });
        }
      }),
    );
  }





}

typedef Null ItemSelectedCallback(int value);


class ListWidget extends StatefulWidget {
  final ItemSelectedCallback onItemSelected;
  ListWidget(
      this.onItemSelected,
      );

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, position) {
        return ListTile(
          title: Text(position.toString()),
          onTap: () => widget.onItemSelected(position),
        );
      },
    );
  }
}



class DetailWidget extends StatefulWidget {

  final int data;

  DetailWidget(this.data);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('index: ${widget.data}'),
          ],
        ),
      ),
    );
  }
}
