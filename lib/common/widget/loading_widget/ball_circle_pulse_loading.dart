import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'ball.dart';
import 'ball_style.dart';
import 'delay_tween.dart';

///
/// desc:
///

class BallCirclePulseLoading extends StatefulWidget {
  final double radius;
  final BallStyle ballStyle;
  final Duration duration;
  final Curve curve;
  final int count;

  const BallCirclePulseLoading(
      {Key? key,
      this.radius = 24,
      required this.ballStyle,
      this.count = 11,
      this.duration = const Duration(milliseconds: 1000),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _BallCirclePulseLoadingState createState() => _BallCirclePulseLoadingState();
}

class _BallCirclePulseLoadingState extends State<BallCirclePulseLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    _animation = _controller.drive(CurveTween(curve: widget.curve));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlow(widget.radius),
      children: List.generate(widget.count, (index) {
        return Center(
          child: ScaleTransition(
            scale: DelayTween(begin: 0.0, end: 1.0, delay: index * .1)
                .animate(_animation),
            child: Ball(
                style: kDefaultBallStyle.copyWith(
                    size: widget.ballStyle.size,
                    color: widget.ballStyle.color,
                    ballType: widget.ballStyle.ballType,
                    borderWidth: widget.ballStyle.borderWidth,
                    borderColor: widget.ballStyle.borderColor)),
          ),
        );
      }),
    );
  }
}

class _CircleFlow extends FlowDelegate {
  final double radius;

  _CircleFlow(this.radius);

  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 0; //??????(0,0)?????????????????????
    double y = 0;
    for (int i = 0; i < context.childCount; i++) {
      x = radius * cos(i * 2 * pi / (context.childCount - 1)); //????????????????????????
      y = radius * sin(i * 2 * pi / (context.childCount - 1)); //????????????????????????
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
