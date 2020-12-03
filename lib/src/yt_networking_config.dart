import 'package:dio/dio.dart';

class YTNetWorkingConfig {
  // 请求域名
  final String baseUrl;
  // 成功value
  final String successValue;
  // 成功code
  final String successKey;
  // 业务data键值
  final String dataKey;
  // 每次请求添加默认参数
  final Function(Map generalParameter) generalParameterCallBack;
  // 业务失败回调
  final Function(Map bean) failCallBack;
  // 请求失败回调
  final Function(DioError error) errorCallBack;
  // 超时时间
  final int connectTimeout;
  // 日志开关
  final bool debugLog;
  // 预留拦截器数组，方便后期添加其他业务逻辑处理
  final List<Interceptor> interceptors;
  // 请求header
  final Map<String, dynamic> headers;

  const YTNetWorkingConfig(
      {this.baseUrl,
        this.successKey,
        this.successValue,
        this.dataKey,
        this.connectTimeout,
        this.debugLog,
        this.generalParameterCallBack,
        this.interceptors,
        this.failCallBack,
        this.errorCallBack,
        this.headers})
      : assert(
  (!(baseUrl == null) && !(baseUrl.length == 0)),
  'baseUrl 未设置',
  );
}
