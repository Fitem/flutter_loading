import 'package:flutter/material.dart';
import 'package:flutter_loading/common/app_colors.dart';
import 'package:flutter_loading/routes/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 屏幕尺寸初始化
    return ScreenUtilInit(
      designSize: Size(373, 667),
      builder: (context, child) => MaterialApp(
        title: 'Flutter Widget',
        theme: ThemeData(
          primaryColor: AppColors.primaryBgBlue,
        ),
        home: HomePage(),
      ),
    );
  }
}