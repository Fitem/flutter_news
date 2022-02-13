import 'package:flutter/material.dart';
import 'package:flutter_news/common/widget/loading_widget/net_loading_dialog.dart';
import 'package:flutter_news/values/values.dart';

///  Name: base基类，StatelessWidget的基类
///  ProjectName: hn_lottery_app
///  Created by leiguangwu on 2021/5/25 .
///  Copyright (C), 2015-2021, 深圳穗彩
abstract class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);

  static var _loadingShowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(), // 子类实现AppBar
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: getBackgroundColor(),
        child: buildBody(),
      ),
    );
  }

  /// Appbar
  AppBar? buildAppBar();

  /// 子类实现Widget
  Widget? buildBody();

  /// 页面背景颜色
  Color getBackgroundColor() {
    return AppColors.secondBgGreen;
  }

  void showLoading() {
    if (_loadingShowing) {
      dismissLoading();
    }
    _loadingShowing = true;
    showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (_) {
          return NetLoadingDialog(
            outsideDismiss: false,
          );
        });
  }

  void dismissLoading() {
    if (_loadingShowing) {
      _loadingShowing = false;
      Get.back();
    }
  }
}
