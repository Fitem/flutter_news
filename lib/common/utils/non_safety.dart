///  Name:空安全校验
///  ProjectName: hn_lottery_app
///  Created by leiguangwu on 2021/5/10 .
///  Copyright (C), 2015-2021, 深圳穗彩

/// 空安全校验，可传默认值
String checkNullForString(var str, {String def = ""}) {
  return str is String ? str : def;
}

int checkNullForInt(var value, {int def = 0}) {
  return value is int ? value : def;
}

double checkNullForDouble(var value, {double def = 0.0}) {
  return value is double ? value : def;
}

bool checkNullForBool(var value, {bool def = false}) {
  return value is bool ? value : def;
}
