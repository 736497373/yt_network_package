import 'package:dio/dio.dart';
import 'yt_networking_config.dart';

///每次默认请求添加参数
class YTNetworkingGeneralParametersInterceptor extends Interceptor {
  final YTNetWorkingConfig config;

  YTNetworkingGeneralParametersInterceptor(this.config);
  @override
  Future onRequest(RequestOptions options) async {
    config.generalParameterCallBack(options.queryParameters);
    return options;
  }
}
