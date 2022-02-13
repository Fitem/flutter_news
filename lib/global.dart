
class Global {
  /// token
  static String token = "";

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static bool get isProfileMode => bool.fromEnvironment('dart.vm.profile');

  static bool get isDebugMode => !isRelease && !isProfileMode;

  ///日志打印 控制开关 log_enable
  static bool logSwitch  = true;
}