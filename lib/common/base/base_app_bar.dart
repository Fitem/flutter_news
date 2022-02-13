import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news/common/router/router.dart';
import 'package:flutter_news/common/utils/utils.dart';
import 'package:get/get.dart';

///  Name: AppBar基类，对AppBar封装统一处理
///  [name] 标题的名称
///  [title] 标题Widget,优先显示[title],若没有[title]则显示[name]
///  [centerTitle] 标题是否居中，默认居中
///  [style] 状态栏显示模式，默认为dark模式
///  [elevation] 标题的阴影
///  [backgroundColor] 背景颜色
///  [actions] menu
///  Created by leiguangwu on 2021/6/16
AppBar buildBaseAppBar({
  String? name, // 标题String
  Widget? title, // 标题View
  bool centerTitle = true, // 标题是否居中，默认居中
  SystemUiOverlayStyle style = SystemUiOverlayStyle.light, // 状态栏显示模式，默认为dark模式
  double? elevation, // 标题的阴影
  Color? backgroundColor, // 背景颜色
  List<Widget>? actions, // menu
}) {
  // 有title则显示title，否则根据name显示默认的title
  title ??= name == null ? null : Text(name);
  return AppBar(
    title: title,
    centerTitle: centerTitle,
    systemOverlayStyle: style,
    elevation: elevation,
    backgroundColor: backgroundColor,
    actions: actions,
  );
}

AppBar buildGameAppBar({
  String? name, // 标题String
  Widget? title, // 标题View
  bool centerTitle = true, // 标题是否居中，默认居中
  SystemUiOverlayStyle style = SystemUiOverlayStyle.light, // 状态栏显示模式，默认为dark模式
  double? elevation, // 标题的阴影
  Color? backgroundColor, // 背景颜色
  // List<Widget> actions, // menu
}) {
  // 有title则显示title，否则根据name显示默认的title
  title ??= name == null ? null : Text(name);
  return AppBar(
    title: title,
    centerTitle: centerTitle,
    systemOverlayStyle: style,
    elevation: elevation,
    backgroundColor: backgroundColor,
    actions: _buildAction(),
  );
}

/// 菜单
List<Widget> _buildAction() {
  return [
    IconButton(
      icon: const ImageIcon(AssetImage("images/menu_account.png")),
      onPressed: () {
        ToastUtil.show("Click Account Menu!");
      },
    ),
    IconButton(
      icon: const ImageIcon(AssetImage("images/menu_shopping_car.png")),
      onPressed: () {
        Get.toNamed(Routes.shoppingCart);
      },
    ),
  ];
}
