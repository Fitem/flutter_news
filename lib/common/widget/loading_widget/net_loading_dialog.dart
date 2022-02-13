import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news/common/widget/loading_widget/loading.dart';
import 'package:flutter_news/values/values.dart';

class NetLoadingDialog extends StatelessWidget {
  String loadingText;
  bool outsideDismiss;
  Function? dismissCallback;

  NetLoadingDialog({
    Key? key,
    this.loadingText = 'Loading...',
    this.outsideDismiss = true,
    this.dismissCallback,
  }) : super(key: key);

  Future<bool> goMenuBack() {
    if (outsideDismiss) {
      ///允许点击隐藏
      _dismissDialog();
    }
    return Future.value(false);
  }

  void _dismissDialog() {
    if (dismissCallback != null) {
      dismissCallback!();
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: goMenuBack,
      child: GestureDetector(
        onTap: outsideDismiss ? _dismissDialog : null,
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: 120,
              height: 120,
              decoration:  BoxDecoration(
                color: AppColors.primaryBgWhite,
                borderRadius: r4Radius,
              ),
              child: const BallCirclePulseLoading(
                ballStyle: BallStyle(
                  size: 10,
                  color: AppColors.primaryBgGreen,
                  ballType: BallType.solid,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
