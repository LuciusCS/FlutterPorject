import 'package:dio/dio.dart';
/// header拦截器
class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {
    ///超时
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);

    return super.onRequest(options, handler);
  }
}
