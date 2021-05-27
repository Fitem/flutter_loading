# flutter_loading

一个Flutter通用页面加载Loading

## LoadingStatus

~~~
/// 状态枚举
enum LoadingStatus {
  idle, // 初始化
  loading, // 加载中
  loading_suc, // 加载成功
  loading_suc_but_empty, // 加载成功但是数据为空
  network_blocked, // 网络加载错误
  error, // 加载错误
}
~~~

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
