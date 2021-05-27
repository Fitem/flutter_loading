import 'package:flutter/material.dart';

///  Name:
///  Created by Fitem on 2021/5/27 .
class WidgetUtil {

  /// 圆角白色背景
  static BoxDecoration buildRadiusDecoration({double radius = 4, Color color = Colors.white}) {
    return BoxDecoration(
      color: color, // 底色
      borderRadius: BorderRadius.circular(radius),);
  }
}