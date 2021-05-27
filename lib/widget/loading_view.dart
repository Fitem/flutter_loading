import 'package:flutter/material.dart';
import 'package:flutter_loading/common/app_colors.dart';
import 'package:flutter_loading/common/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///  Name: 页面加载Loading
///  Created by fitem on 2021/5/24 .
typedef OnTapCallback = Function(LoadingView widget);

// ignore: must_be_immutable
class LoadingView extends StatefulWidget {
  LoadingView({
    Key key,
    @required this.child, // 需要加载的Widget
    @required this.todoAfterError, // 错误点击重试
    @required this.todoAfterNetworkBlocked, // 网络错误点击重试
    this.networkBlockedDesc = "网络连接超时，请检查你的网络环境",
    this.errorDesc = "加载失败",
    this.loadingStatus = LoadingStatus.idle,
  }) : super(key: key);

  // 需要加载的Widget
  final Widget child;

  // 接口错误加载重试
  final OnTapCallback todoAfterError;

  // 网络错误加载重试
  final OnTapCallback todoAfterNetworkBlocked;

  // 网络错误提示文案
  final String networkBlockedDesc;

  // 接口错误提示文案
  final String errorDesc;

  // 初始化记载状态
  LoadingStatus loadingStatus;
  _LoadingViewState _state;

  @override
  _LoadingViewState createState() {
    _state = _LoadingViewState();
    return _state;
  }

  /// 更新LoadingStatus
  void updateStatus(LoadingStatus status) {
    // 避免widget在build时setState()
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("updateStatus:$status");
      _state?.updateStatus(status);
    });
  }
}

class _LoadingViewState extends State<LoadingView> {
  /// 加载中 View
  Widget _buildLoadingView() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
        child: SizedBox(
          height: 22.w,
          width: 22.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBgBlue),
          ),
        ),
      ),
    );
  }

  /// 编译通用页面
  Container _buildGeneralTapView({
    String url = "images/icon_network_blocked.png",
    String desc,
    @required Function onTap,
  }) {
    return Container(
      color: AppColors.primaryBgWhite,
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(
        child: SizedBox(
          height: 250.h,
          child: Column(
            children: [
              Image.asset(url,
                  width: 140.w, height: 99.h),
              SizedBox(
                height: 40.h,
              ),
              Text(
                desc,
                style: AppText.gray50Text12,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 30.h,
              ),
              if (onTap != null)
                BorderRedBtnWidget(
                  content: "重新加载",
                  onClick: onTap,
                  padding: 40.w,
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// 加载成功但数据为空 View
  Widget _buildLoadingSucButEmptyView() {
    return _buildGeneralTapView(
      url: "images/icon_empty.png",
      desc: "暂无数据",
      onTap: null,
    );
  }

  /// 网络加载错误页面
  Widget _buildNetworkBlockedView() {
    return _buildGeneralTapView(
        url: "images/icon_network_blocked.png",
        desc: widget.networkBlockedDesc,
        onTap: () {
          widget.todoAfterNetworkBlocked(widget);
        });
  }

  /// 加载错误页面
  Widget _buildErrorView() {
    return _buildGeneralTapView(
        url: "images/icon_error.png",
        desc: widget.errorDesc,
        onTap: () {
          widget.todoAfterError(widget);
        });
  }

  /// body by status
  Widget _buildBody() {
    switch (widget.loadingStatus) {
      case LoadingStatus.idle:
        return widget.child;
      case LoadingStatus.loading:
        return _buildLoadingView();
      case LoadingStatus.loading_suc:
        return widget.child;
      case LoadingStatus.loading_suc_but_empty:
        return _buildLoadingSucButEmptyView();
      case LoadingStatus.error:
        return _buildErrorView();
      case LoadingStatus.network_blocked:
        return _buildNetworkBlockedView();
    }
    return widget.child;
  }

  /// 更新LoadingStatus
  void updateStatus(LoadingStatus status) {
    setState(() {
      widget.loadingStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}

/// 状态枚举
enum LoadingStatus {
  idle, // 初始化
  loading, // 加载中
  loading_suc, // 加载成功
  loading_suc_but_empty, // 加载成功但是数据为空
  network_blocked, // 网络加载错误
  error, // 加载错误
}

///红色圆角边框 btn
class BorderRedBtnWidget extends StatelessWidget {
  const BorderRedBtnWidget({
    Key key,
    padding = 16,
    radius = 19.0,
    @required content,
    @required onClick,
  })  : _content = content,
        _padding = padding,
        _onClick = onClick,
        _radius = radius,
        super(key: key);

  final String _content;
  final double _padding;
  final Function _onClick;
  final double _radius; //圆角

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onClick,
      child: Text("$_content"),
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(AppText.blueText12),
          backgroundColor: MaterialStateProperty.all(AppColors.white),
          foregroundColor: MaterialStateProperty.all(AppColors.primaryTextBlue),
          side: MaterialStateProperty.all(
            BorderSide(
              color: AppColors.primaryBgBlue,
              width: 0.8.w,
            ),
          ),
          padding: MaterialStateProperty.all(
              EdgeInsets.only(left: _padding, right: _padding)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_radius))))),
    );
  }
}
