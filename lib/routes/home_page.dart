import 'package:flutter/material.dart';
import 'package:flutter_loading/common/app_colors.dart';
import 'package:flutter_loading/common/app_text.dart';
import 'package:flutter_loading/routes/loading_demo_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///  Name:
///  Created by Fitem on 2021/5/27 .
class HomePage extends StatelessWidget {
  /// item
  Widget _buildItems({@required String title, @required Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppColors.white,
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
        height: 45.h,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppText.gray90Text14,
              ),
            ),
            Image.asset(
              "images/icon_arrow_right.png",
              width: 8.5.w,
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("组件"),
      centerTitle: true,
      brightness: Brightness.dark,
    );
  }

  /// body
  Widget _buildBody(BuildContext context) {
    return ListView(children: [
      _buildItems(
          title: "页面加载Loading",
          onTap: () {
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) {
              return LoadingDemoPage();
            }));
          })
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: AppColors.primaryBgGray,
        child: _buildBody(context),
      ),
    );
  }
}
