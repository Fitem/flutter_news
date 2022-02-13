
import 'package:flutter_news/values/values.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Copyright (C), 2015-2021, 深圳穗彩
///FileName: toast_util
///Author: gongpan
///Date: 2021/4/20 14:53
///Description: toast  工具类

class ToastUtil {

  static void showCenter(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: AppColors.primaryToastBg,
        textColor: AppColors.primaryBgWhite,
        fontSize: 16.0);
  }

  static void show(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.primaryToastBg,
        textColor: AppColors.primaryBgWhite,
        fontSize: 16.0);
  }
}
