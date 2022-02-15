import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_news/common/router/router_page.dart';
import 'package:flutter_news/l10n/localization_intl.dart';
import 'package:flutter_news/modules/home/screen/home_screen.dart';
import 'package:flutter_news/values/values.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color themeColor = AppColors.primaryBgGreen;
    return ScreenUtilInit(
        designSize: const Size(373, 667),
        builder: () {
          return GetMaterialApp(
            onGenerateTitle: (context){
              return DemoLocalizations.of(context)!.title;
            },
            theme: ThemeData(
                primaryColor: themeColor,
                // Appbar标题和action为深色模式
                primaryColorBrightness: Brightness.dark,
                primarySwatch: MaterialColor(themeColor.value, <int, Color>{
                  50: themeColor,
                  100: themeColor,
                  200: themeColor,
                  300: themeColor,
                  400: themeColor,
                  500: themeColor,
                  600: themeColor,
                  700: themeColor,
                  800: themeColor,
                  900: themeColor,
                })),
            localizationsDelegates: const [
              // 本地化的代理类
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              // 注册我们的Delegate
              DemoLocalizationsDelegate(),
            ],
            supportedLocales: const [
              Locale('en', 'US'), // 美国英语
              Locale('zh', 'CN'), // 中文简体
              //其它Locales
            ],
            home: HomeScreen(),
            getPages: AppPages.pages,
          );
        });
  }
}
