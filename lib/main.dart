import 'dart:async';
import 'dart:developer';

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
import 'package:mmkv/mmkv.dart';
import 'package:stack_trace_info/stack_trace_info.dart';

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
  // 设置全局错误处理小部件， 应用的未知不太一样
  // ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
  //   // 打印错误信息
  //   debugPrint(flutterErrorDetails.toString());
  //
  //   // 返回一个自定义的错误小部件，比如一个居中的错误文本
  //   return Center(
  //     child: Text(
  //       "App错误，快去反馈给作者!",
  //       style: TextStyle(color: Colors.red, fontSize: 18),
  //     ),
  //   );
  // };

  // must wait for MMKV to finish initialization
  final rootDir = await MMKV.initialize();
  print('MMKV for flutter with rootDir = $rootDir');

  final StackTraceInfo info = StackTraceInfo(trace: StackTrace.current);
  log(info.fileName);
  // 捕获 Dart 异步代码的异常, 既有同步异常，也有异步异常
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await initServices();

    await MySharedPref.init();

    Get.put(SettingService());

    ///用于统一显示错误页面
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      //自定义错误提示页面
      return Scaffold(
          body: Center(
        child: Text("Custom Error Widget"),
      ));
    };

    //方法一  捕获 Flutter 框架的异常，对于这种异常能不能统一显示一个页面
    FlutterError.onError = (FlutterErrorDetails details) async {
      // 输出到控制台
      // FlutterError.dumpErrorToConsole(details);
      // 转储到设备日志
      print('捕获到 Flutter 异常: ${details.exceptionAsString()}');
      print('堆栈信息: ${details.stack.toString()}');

      if (isDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        ///，我们使用 Zone 提供的 handleUncaughtError 语句，将 Flutter 框架的异常统一转发到当前的 Zone 中，这样我们就可以统一使用 Zone 去处理应用内的所有异常了：
        Zone.current.handleUncaughtError(details.exception, details.stack!);
        await _uploadError(
            details.exceptionAsString(), details.stack.toString());
      }

      //自定义错误提示页面
      // return Scaffold(
      //     body: Center(
      //       child: Text("Custom Error Widget"),
      //     )
      // );
    };

    // FlutterError.onError = (FlutterErrorDetails details) async {
    //   // 转发至 Zone 中
    //   Zone.current.handleUncaughtError(details.exception, details.stack);
    // };

    ///需要对其进行注册
    // 同时你可以给 runZoned 注册方法，在需要时执行回调，如下代码所示，这样的在一个 Zone 内任何地方，只要能获取 onData 这个 ZoneUnaryCallback，就都可以调用到 handleData///最终需要处理的地方
    // handleData(result) {
    //   print("VVVVVVVVVVVVVVVVVVVVVVVVVVV");
    //   print(result);
    // }
    //返回得到一个 ZoneUnaryCallback
    // var onData = Zone.current.registerUnaryCallback<dynamic, int> (handleData);
    //执行 ZoneUnaryCallback 返回数据
    // Zone.current.runUnary(onData, 2);
    //异步逻辑可以通过 scheduleMicrotask 可以插入异步执行方法:
    // Zone.current.scheduleMicrotask((){
    ////todo  something
    //});

    runApp(
        // MyApp()

        ///用于对屏幕的尺寸进行适配
        ScreenUtilInit(
            // todo add your (Xd / Figma) artboard size
            /**
           * reenUtil 依赖于指定的基准尺寸，也就是设计稿的宽高。开发者通常在项目初始化时传入这个基准尺寸，ScreenUtil 以此为参考对所有控件进行缩放。
           */

            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            rebuildFactor: (old, data) => true,
            builder: (context, widget) {
              return MyApp();
            }));
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

/**
 * 因此，对于Dart中出现的异常，同步异常使用的是try-catch，异步异常则使用的是catchError。如果想集中管理代码中的所有异常，
 * 那么可以Flutter提供的Zone.runZoned()方法。在Dart语言中，Zone表示一个代码执行的环境范围，其概念类似沙盒，
 * 不同沙盒之间是互相隔离的。如果想要处理沙盒中代码执行出现的异常，可以使用沙盒提供的onError回调函数来拦截那些在代码执行过程中未捕获的异常，如下所示。
 *
 * ```
 * //同步抛出异常
    runZoned(() {
    throw StateError('This is a Dart exception.');
    }, onError: (dynamic e, StackTrace stack) {
    print('Sync error caught by zone');
    });

    //异步抛出异常
    runZoned(() {
    Future.delayed(Duration(seconds: 1))
    .then((e) => throw StateError('This is a Dart exception in Future.'));
    }, onError: (dynamic e, StackTrace stack) {
    print('Async error aught by zone');
    });
 * ```
 * 可以看到，在没有使用try-catch、catchError语句的情况下，无论是同步异常还是异步异常，都可以使用Zone直接捕获到。

    同时，如果需要集中捕获Flutter应用中未处理的异常，那么可以把main函数中的runApp语句也放置在Zone中，
    这样就可以在检测到代码运行异常时对捕获的异常信息进行统一处理，如下所示。
 */

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
        builder: (context, widget) {
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
        locale: MySharedPref.getCurrentLocal(),
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

  /***
   *
   * GlobalKey 是 Flutter 中一个非常有用的工具，
   * 用于在应用程序的不同部分之间共享状态或引用特定的组件。它在需要跨组件树访问状态、在 Navigator 中维持页面状态、
   * 或在表单中进行验证时特别有用。然而，由于性能开销，建议仅在确有必要的场景下使用 GlobalKey。
   *
   *
   * GlobalKey 的注意事项
      性能开销：GlobalKey 的使用会带来一些性能开销，特别是在复杂的组件树中，因为它需要在树中进行唯一性检查和维护。所以应该尽量减少 GlobalKey 的使用，只在必要的场景下使用它。
      GlobalKey 的唯一性：一个 GlobalKey 实例应该只分配给树中的一个组件。重复使用同一个 GlobalKey 会导致错误或不可预测的行为。
   *
   *
   * 1. GlobalKey 的作用
      访问 Widget 的状态：通过 GlobalKey，你可以在组件树的其他位置访问和操作一个特定 StatefulWidget 的 State 对象。
      跨组件树引用 Widget：GlobalKey 可以唯一标识一个 Widget，即使它在组件树的深层次中，这使得你可以从不同的地方访问它。
      维持状态：在 Flutter 的 Navigator 中，GlobalKey 常常用于保持页面的状态，确保在页面重新构建时状态不会丢失。
      2. GlobalKey 的使用场景
      从父组件访问子组件的状态：如果一个子组件的状态需要由父组件或兄弟组件访问或控制，使用 GlobalKey 是一种解决方案。
      在 Navigator 中维护页面状态：当你使用 Navigator 推送和弹出页面时，GlobalKey 可以用来确保页面在重建时能保留原有的状态。
      表单验证：在复杂的表单中，使用 GlobalKey 可以访问 FormState，从而在表单提交时触发验证和保存操作。
   *
   */
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
