import 'package:flutter/material.dart';
import 'package:flutter_loading/common/app_colors.dart';
import 'package:flutter_loading/widget/loading_view.dart';

///  Name: LoadingWidget的Demo页面
///  Created by fitem on 2021/5/24 .
class LoadingDemoPage extends StatelessWidget {

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("LoadingView"),
      centerTitle: true,
      brightness: Brightness.dark,
    );
  }

  Widget _buildBody() {
     var loadingView = LoadingView(
      loadingStatus: LoadingStatus.loading,
      child: _buildContent(),
      todoAfterNetworkBlocked: (LoadingView widget) {
        // 网络错误，点击重试
        widget.updateStatus(LoadingStatus.loading);
        Future.delayed(Duration(milliseconds: 1000), () {
          widget.updateStatus(LoadingStatus.error);
        });
      },
      todoAfterError: (LoadingView widget) {
        // 接口错误，点击重试
        widget.updateStatus(LoadingStatus.loading);
        Future.delayed(Duration(milliseconds: 1000), () {
          // widget.updateStatus(LoadingStatus.loading_suc);
          widget.updateStatus(LoadingStatus.loading_suc_but_empty);
        });
      },
    );
     Future.delayed(Duration(milliseconds: 1000), (){
       loadingView.updateStatus(LoadingStatus.network_blocked);
     });
     return loadingView;
  }

  Widget _buildContent() {
    return Center(child: Text("这是网络请求后的内容"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: AppColors.primaryBgGray,
        child: _buildBody(),
      ),
    );
  }
}
