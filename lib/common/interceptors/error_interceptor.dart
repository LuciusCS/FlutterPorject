
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../net/code.dart';
import '../net/result_data.dart';


/// 错误拦截

class ErrorInterceptors extends InterceptorsWrapper {


  @override
  onRequest(RequestOptions options, handler) async {
    //没有网络
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          response: Response(
              requestOptions: options,
              data: ResultData(
                  Code.errorHandleFunction(Code.NETWORK_ERROR, "", false),
                  false,
                  Code.NETWORK_ERROR))));
    }
    return super.onRequest(options, handler);
  }
}
