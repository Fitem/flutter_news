import 'package:flutter/cupertino.dart';
import 'package:flutter_news/global.dart';

/// Copyright (C), 2015-2021, 深圳穗彩
///FileName: log_util
///Author: gongpan
///Date: 2021/4/19 18:58
///Description:  打印工具类

class LogUtil {
  static void println(String obj) {
    if (Global.isDebugMode) debugPrint(obj);
  }
}
