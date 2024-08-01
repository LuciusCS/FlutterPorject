import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_project/common/services/setting_service.dart';

import 'package:flutter_project/page/splash/splash_view.dart';
import 'package:flutter_project/router/route_config.dart';
import 'package:flutter_project/utils/NavigationObserver.dart';
import 'package:flutter_project/utils/NavigationService.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'bindings/initial_binding.dart';
import 'common/base/app_themes.dart';
import 'common/event/http_error_event.dart';
import 'common/event/index.dart';
import 'common/local/my_shared_pref.dart';
import 'common/net/code.dart';
import 'common/services/app_service.dart';

import 'common/theme/my_theme.dart';
import 'common/translations/localization_service.dart';

Future<void> main() async {


  // 捕获 Dart 异步代码的异常
  runZonedGuarded(() async {

    WidgetsFlutterBinding.ensureInitialized();

    await initServices();

    await MySharedPref.init();


    Get.put(SettingService());


    // 捕获 Flutter 框架的异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      // 输出到控制台
      // FlutterError.dumpErrorToConsole(details);
      // 转储到设备日志
      print('捕获到 Flutter 异常: ${details.exceptionAsString()}');
      print('堆栈信息: ${details.stack.toString()}');


      if (isDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
        await _uploadError(details.exceptionAsString(), details.stack.toString());

      }
    };
    runApp(
        // MyApp()

        ScreenUtilInit(
          // todo add your (Xd / Figma) artboard size
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            rebuildFactor: (old, data) => true,
            builder: (context, widget) {

              return MyApp();

            })



    );
  }, (Object error, StackTrace stack) async {
    // 转储到设备日志
    print('捕获到 Dart 异常: $error');
    print('堆栈信息: $stack');
    await _uploadError(error.toString(), stack.toString());
  });


}


bool get isDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<void> _uploadError(String error, String stackTrace) async {
  // 这里实现将错误信息上传到服务器的逻辑
}

Future initServices() async {
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => AppService().init());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with HttpErrorListener {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   navigatorObservers: [NavigationObserver()],
    //   navigatorKey: NavigationService().navigatorKey,
    //   onGenerateRoute: generateRoute,
    //   initialRoute: '/',
    // );
    return GestureDetector(
      onTap: hideKeyboard,
      child: GetMaterialApp(
        // home: SplashPage(),
        // theme: AppThemes.lightTheme,

        title: "GetXSkeleton",
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        builder: (context,widget) {
          bool themeIsLight = MySharedPref.getThemeIsLight();
          return Theme(
            data: MyTheme.getThemeData(isLight: themeIsLight),
            child: MediaQuery(
              // prevent font from scalling (some people use big/small device fonts)
              // but we want our app font to still the same and dont get affected
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            ),
          );
        },
        // darkTheme: AppThemes.darkTheme,
        // themeMode: ThemeMode.system,
        initialBinding: InitialBinding(),

        initialRoute: RouteConfig.splash,
        getPages: RouteConfig.getPages,
        // localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        //   S.delegate,
        // ],
        locale:  MySharedPref.getCurrentLocal(),
        translations: LocalizationService.getInstance(),

      ),
    );
  }



  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

mixin HttpErrorListener on State<MyApp> {
  StreamSubscription? stream;

  GlobalKey<NavigatorState> navKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream!.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int? code, message) {
    var context = navKey.currentContext!;
    switch (code) {
      case Code.NETWORK_ERROR:
        // showToast(GSYLocalizations.i18n(context)!.network_error);
        break;
      case 401:
        // showToast(GSYLocalizations.i18n(context)!.network_error_401);
        break;
      case 403:
        // showToast(GSYLocalizations.i18n(context)!.network_error_403);
        break;
      case 404:
        // showToast(GSYLocalizations.i18n(context)!.network_error_404);
        break;
      case 422:
        // showToast(GSYLocalizations.i18n(context)!.network_error_422);
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        // showToast(GSYLocalizations.i18n(context)!.network_error_timeout);
        break;
      case Code.GITHUB_API_REFUSED:
        //Github API 异常
        // showToast(GSYLocalizations.i18n(context)!.github_refused);
        break;
      default:
        // showToast(
        //     "${GSYLocalizations.i18n(context)!.network_error_unknown} $message");
        break;
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }
}
