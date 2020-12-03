# yt_network_package

#### 简单的dart网络层封装,通过配置,让业务上层只关心业务数据



## 实现功能包括
 * get
 * post
 * put
 * delete


## 使用
``` dart

yt_network_package:
    git:
      url: https://github.com/736497373/yt_network_package.git


import 'package:yt_network_package/yt_network_package.dart';

```

## Usage

### 基础配置
```dart

  YTNetWorkingConfig config = YTNetWorkingConfig(
    // 请求域名
    baseUrl: baseUrl,
    // 成功key
    successKey: successKey,
    // 成功value
    successValue: successValue,
    // 业务dataKey
    dataKey: dataKey,
    // 设置headers
    headers: {'key': 'value'},
    // 是否打印log
    debugLog: true,
    // 每次请求添加默认参数
    generalParameterCallBack: (generalParameter) {
      return generalParameter;
    },
    // 定义业务错误,在此处统一处理，忽略错误，提供错误回调、提示之类动作
    failCallBack: (bean) {},
    /// 请求失败回调
    errorCallBack: (error) {},
  );
  YTNetWorkingManager(config: config);

```

### 使用

```
 YTNetWorkingManager().get(api, params: {}, resultCallBack: (result) {
      print('请求成功');
 });
```
##### 若需要自定义错误动作
```
 YTNetWorkingManager().get(
      api,
      params: {},
      resultCallBack: (result) {
        print('请求成功');
      },
      failCallBack: (result) {
        print('自定义请求失败动作');
      },
      errorCallBack: (error) {
        print('自定义接口请求失败' + error.toString());
   	  }
 );

```




## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
