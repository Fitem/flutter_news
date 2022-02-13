import 'package:flutter/material.dart';
import 'package:flutter_news/values/values.dart';

///  Name: 基础组件，统一封装用于主题色切换
///  Created by leiguangwu on 2021/12/21

/// CupertinoSwitch
Widget buildSwitch({
  required bool value,
  required ValueChanged<bool> onChanged,
  Color? actionColor,
}) {
  return Switch(
    activeColor: actionColor,
    value: value,
    onChanged: onChanged,
  );
}

/// 消息msg
Widget buildMsgCount(int num){
  return Offstage(
    offstage: num <= 0,
    child: Container(
      decoration: BoxDecoration(
        border:  Border.all(
            color: AppColors.primaryTextWhite80, width: 1.w),
        color: AppColors.primaryBgGreen,
        borderRadius: r12Radius,
      ),
      height: 15.w,
      width: 15.w,
      alignment: Alignment.center,
      child: Text(
        "$num",
        style: AppText.whiteText10,
      ),
    ),
  );
}

/// BottomNavigationBar
Widget buildBottomNavigationBar({
  required List<BottomNavigationBarItem> items,
  required int currentIndex,
  required ValueChanged<int> onTap,
}) {
  return BottomNavigationBar(
    items: items,
    type: BottomNavigationBarType.fixed,
    currentIndex: currentIndex,
    onTap: onTap,
    // selectedItemColor: BaseDateController.get().themeColor,
    unselectedItemColor: AppColors.primaryTextBlack45,
    backgroundColor: AppColors.primaryBgWhite,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  );
}

/// 显示投注成功弹窗
void showBetSuccessfulDialog({GestureTapCallback? onTap}){
  showDialog<void>(
    barrierDismissible: false,
    context: Get.context!,
    builder: (BuildContext dialogContext) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 270.w,
            height: 256.w,
            child: Dialog(
              insetPadding : EdgeInsets.zero,
              child: SizedBox(
                width: 270.w,
                height: 256.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: onTap,
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            child: Image.asset("images/icon_close_black.png",
                                width: 20.w, height: 20.w),
                          ),
                        ),
                      ],
                    ),
                    Image.asset("images/icon_bet_successful.png", width: 60.w, height: 60.w),
                    SizedBox(height: 12.w),
                    Text(
                      "Successful!",
                      style: AppText.black85Text20,
                    ),
                    SizedBox(height: 40.w),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        width: 188.w,
                        height: 44.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBgGreen,
                          borderRadius: r8Radius,
                        ),
                        child: Text("Confirm", style: AppText.whiteText16),
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        ),
      );
    },
  );
}

///圆角 btn
class GlButtonWidget extends StatelessWidget {
  const GlButtonWidget({
    Key? key,
    required String content,
    VoidCallback? onClick,
    padding = 20.0,
    paddingVertical = 6.0,
    this.textSize,
    this.elevation,
  })  : _onClick = onClick,
        _paddingHorizon = padding,
        _content = content,
        _paddingVertical = paddingVertical,
        super(key: key);

  final VoidCallback? _onClick;
  final String _content;
  final double _paddingHorizon;
  final double _paddingVertical;
  final double? elevation;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onClick,
      child: Text(
        _content,
        style: TextStyle(fontSize: textSize ?? 15.sp),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.only(
            left: _paddingHorizon,
            right: _paddingHorizon,
            top: _paddingVertical,
            bottom: _paddingVertical)),
        foregroundColor: MaterialStateProperty.all(AppColors.primaryBgWhite),
        elevation:
        elevation == null ? null : MaterialStateProperty.all(elevation),
        // backgroundColor: MaterialStateProperty.all(
        //     BaseDateController.get().themeColor.value),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.h)))),
      ),
    );
  }
}

/// Radio
Radio buildRadio({
  required int value,
  required int groupValue,
  required ValueChanged<int?>? onChanged,
}) {
  return Radio<int>(
    value: value,
    groupValue: groupValue,
    toggleable: value == groupValue,
    onChanged: onChanged,
  );
}
