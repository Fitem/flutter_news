
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///@describe LineView
///
///@author mi
///
///@time 2019/9/10
class LineView extends StatelessWidget{

  final double height;
  final double top;
  final double bottom;
  final double left;
  final double right;

  LineView({this.height = 10,this.top = 0,this.bottom = 0,this.left = 0,this.right = 0});

  @override
  Widget build(BuildContext context) {

    //return  Container(color: SColor.line_color,height: height,);
    return Container(color:const Color(0xFFEAEEF2),height: height,margin: EdgeInsets.only(top: top,bottom: bottom,left: left,right: right));
  }

}