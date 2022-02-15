import 'package:flutter/material.dart';
import 'package:flutter_news/common/base/base_view.dart';
import 'package:flutter_news/common/base/base_widget.dart';
import 'package:flutter_news/l10n/localization_intl.dart';
import 'package:flutter_news/modules/home/screen/fourth_screen.dart';
import 'package:flutter_news/modules/home/screen/head_screen.dart';
import 'package:flutter_news/modules/home/screen/second_screen.dart';
import 'package:flutter_news/modules/home/screen/third_screen.dart';
import 'package:flutter_news/values/values.dart';

///  Name: home
///  Created by leiguangwu on 2022/2/13
class HomeScreen extends BaseWidget {
  HomeScreen({Key? key}) : super(key: key);

  var currentTab = 0.obs;
  final PageController _pageController = PageController(initialPage: 0);
  late BuildContext context;

  List<BottomNavigationBarItem> get _bottomTabs => [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 20.w,
          ),
          label: DemoLocalizations.of(context)?.title,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.hot_tub_sharp,
            size: 20.w,
          ),
          label: "模块2",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.house_siding_sharp,
            size: 20.w,
          ),
          label: "模块3",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_work_sharp,
            size: 20.w,
          ),
          label: "模块3",
        ),
      ];

  // pageview 页面
  Widget _buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        HeadScreen(),
        SecondScreen(),
        ThirdScreen(),
        FourthScreen(),
      ],
      controller: _pageController,
      onPageChanged: (page) {
        currentTab.value = page;
      },
    );
  }

  // tab栏动画
  void _handleNavBarTap(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  Widget _buildBottomNavBar() {
    return Obx(() => buildBottomNavigationBar(
          items: _bottomTabs,
          currentIndex: currentTab.value,
          onTap: _handleNavBarTap,
        ));
  }

  @override
  AppBar? buildAppBar() {
    return null;
  }

  @override
  Widget? buildBody() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
}
