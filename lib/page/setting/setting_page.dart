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

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final settingService = Get.find<SettingService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarWidget(
      //   title: S.of(context).settings_title,
      //   onBackPressed: () {
      //     Get.back();
      //   },
      // ),
      body: Container(
        padding: EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildThemeSection(),
            _buildLanguageSection(),
          ],
        ),
      ),
    );
  }

  var testTitle = "test".obs;

  Widget _buildThemeSection() {
    final theme = Theme.of(context);
    return Container(
        height: 300,
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 100)),

              Container(
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                ),
                child: Text("测试"),
              ),

              InkWell(
                onTap: () {
                  MyTheme.changeTheme();
                },
                child: Text(
                  '${Strings.changeTheme.tr}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),

              Text(testTitle.value)

              // Text(
              //   S.of(context).settings_themeMode,
              //   style: theme.textTheme.headlineSmall,
              // ),
              // RadioListTile(
              //   title: Text(S.of(context).settings_themeModeSystem),
              //   value: ThemeMode.system,
              //   groupValue: settingService.currentThemeMode.value,
              //   onChanged: (ThemeMode? value) {
              //     if (value != null) {
              //       settingService.changeThemeMode(value);
              //     }
              //   },
              // ),
              // RadioListTile(
              //   title: Text(S.of(context).settings_themeModeLight),
              //   value: ThemeMode.light,
              //   groupValue: settingService.currentThemeMode.value,
              //   onChanged: (ThemeMode? value) {
              //     if (value != null) {
              //       settingService.changeThemeMode(value);
              //     }
              //   },
              // ),
              // RadioListTile(
              //   title: Text(S.of(context).settings_themeModeDark),
              //   value: ThemeMode.dark,
              //   groupValue: settingService.currentThemeMode.value,
              //   onChanged: (ThemeMode? value) {
              //     if (value != null) {
              //       settingService.changeThemeMode(value);
              //     }
              //   },
              // ),
            ],
          );
        }));
    ;
  }

  Widget _buildLanguageSection() {
    final theme = Theme.of(context);
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              LocalizationService.updateLanguage("zh"
                  // LocalizationService.getCurrentLocal().languageCode == 'zh' ? 'en' : 'zh',
                  );
            },
            child: Text(
              '${Strings.chinese.tr}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 10)),

          InkWell(
            onTap: () {
              LocalizationService.updateLanguage("en"
                  // LocalizationService.getCurrentLocal().languageCode == 'zh' ? 'en' : 'zh',
                  );
            },
            child: Text(
              '${Strings.english.tr}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.black,
              ),
            ),
          ),

          ///

          Text(testTitle.value),

          // Text(
          //   S.of(context).settings_language,
          //   style: theme.textTheme.headlineSmall,
          // ),
          // RadioListTile(
          //   title: Text(S.of(context).settings_languageEnglish),
          //   value: Locale.fromSubtags(languageCode: 'en'),
          //   groupValue: settingService.currentLocate.value,
          //   onChanged: (Locale? value) {
          //     if (value != null) {
          //       settingService.updateLocale(value);
          //     }
          //   },
          // ),
          // RadioListTile(
          //   title: Text(S.of(context).settings_languageVietnamese),
          //   value: Locale.fromSubtags(languageCode: 'vi'),
          //   groupValue: settingService.currentLocate.value,
          //   onChanged: (Locale? value) {
          //     if (value != null) {
          //       settingService.updateLocale(value);
          //     }
          //   },
          // ),
        ],
      );
    });
  }
}
