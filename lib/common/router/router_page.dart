import 'package:flutter_news/common/router/router.dart';
import 'package:flutter_news/modules/home/screen/home_screen.dart';
import 'package:get/get.dart';
///  Name:
///  Created by leiguangwu on 2021/12/20
abstract class AppPages {
  static final pages = [

    /// 首页
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      //binding: LoginPageBinding(),
    ),
  ];
}
