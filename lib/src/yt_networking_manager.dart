import 'package:dio/dio.dart';
import 'yt_networking_config.dart';
import 'yt_networking_general_parameters_interceptor.dart';
import 'yt_networking_log_interceptor.dart';

class YTNetWorkingManager {
  static YTNetWorkingManager _instance;
  static Dio _dio;
  static YTNetWorkingConfig _config;

  /// 设置headers
  static set headers(Map headers) {
    if (_dio != null) {
      _dio.options.headers = headers;
    }
  }

  YTNetWorkingManager._({String baseUrl, bool debugLog: false}) {
    if (null == _instance) {
      final header = _config.headers != null ? _config.headers : {};
      _dio = new Dio(new BaseOptions(
          baseUrl: baseUrl,
          headers: header,
          connectTimeout: _config.connectTimeout));

      _dio.interceptors.add(YTNetworkingGeneralParametersInterceptor(_config));
      if (_config.interceptors.isNotEmpty) {
        _dio.interceptors.addAll(_config.interceptors);
      }
      if (debugLog == true) {
        _dio.interceptors.add(new YTNetWorkingLogInterceptor());
      }

      print('YTNetWorkingManager---初始化');
      print('YTNetWorkingManager---baseUrl = $baseUrl');
    }
  }

  factory YTNetWorkingManager({YTNetWorkingConfig config}) {
    if (YTNetWorkingManager._instance == null) {
      _config = config;
      return _instance = YTNetWorkingManager._(
        baseUrl: config.baseUrl,
        debugLog: config.debugLog,
      );
    } else {
      return _instance;
    }
  }

  /// 通用的GET请求
  get(api,
      {params,
        Function(dynamic result) resultCallBack,
        Function(dynamic result) failCallBack,
        Function(DioError error) errorCallBack}) async {
    try {
      Response response =
      await _dio.get(api, queryParameters: params ?? new Map());
      Map data = response.data;
      if (data.isNotEmpty &&
          data.keys.contains(_config.successKey) &&
          data['${_config.successKey}'] == _config.successValue) {
        resultCallBack(response.data['${_config.dataKey}']);
      } else {
        _failManageCallBack(failCallBack, response.data);
      }
    } on DioError catch (onError) {
      _errorManageCallBack(errorCallBack, onError);
    }
  }

  /// 通用的POST请求
  post(api,
      {params,
        Function(dynamic result) resultCallBack,
        Function(dynamic result) failCallBack,
        Function(DioError error) errorCallBack}) async {
    try {
      Response response = await _dio.post(api, data: params ?? new Map());
      Map data = response.data;
      if (data.isNotEmpty &&
          data.keys.contains(_config.successKey) &&
          data['${_config.successKey}'] == _config.successValue) {
        resultCallBack(response.data['${_config.dataKey}']);
      } else {
        _failManageCallBack(failCallBack, response.data);
      }
    } on DioError catch (onError) {
      _errorManageCallBack(errorCallBack, onError);
    }
  }

  /// 通用的put请求
  Future put(api,
      {params,
        Function(dynamic result) resultCallBack,
        Function(dynamic result) failCallBack,
        Function(DioError error) errorCallBack}) async {
    try {
      Response response =
      await _dio.put(api, queryParameters: params ?? new Map());
      Map data = response.data;
      if (data.isNotEmpty &&
          data.keys.contains(_config.successKey) &&
          data['${_config.successKey}'] == _config.successValue) {
        resultCallBack(response.data['${_config.dataKey}']);
      } else {
        _failManageCallBack(failCallBack, response.data);
      }
    } on DioError catch (onError) {
      _errorManageCallBack(errorCallBack, onError);
    }
  }

  /// 通用的delete请求
  Future delete(api,
      {params,
        Function(dynamic result) resultCallBack,
        Function(dynamic result) failCallBack,
        Function(DioError error) errorCallBack}) async {
    try {
      Response response =
      await _dio.delete(api, queryParameters: params ?? new Map());
      Map data = response.data;
      if (data.isNotEmpty &&
          data.keys.contains(_config.successKey) &&
          data['${_config.successKey}'] == _config.successValue) {
        resultCallBack(response.data['${_config.dataKey}']);
      } else {
        _failManageCallBack(failCallBack, response.data);
      }
    } on DioError catch (onError) {
      _errorManageCallBack(errorCallBack, onError);
    }
  }

  // 业务错误处理
  void _failManageCallBack(Function(Map result) failCallBack, Map result) {
    if (failCallBack != null) {
      failCallBack(result);
    } else {
      if (_config.failCallBack != null) {
        _config.failCallBack(result);
      }
    }
  }

  // 请求错误处理
  void _errorManageCallBack(
      Function(DioError error) errorCallBack, DioError error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    } else {
      if (_config.errorCallBack != null) {
        _config.errorCallBack(error);
      }
    }
  }
}
