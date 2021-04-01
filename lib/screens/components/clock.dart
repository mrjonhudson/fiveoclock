import 'dart:async';
import 'dart:math';

import 'package:fiveoclock/models/my_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'clock_painter.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: getSmallestSize(37), horizontal: getSmallestSize(37)),
          child: Container(
            height: getSmallestSize(323),
            width: getSmallestSize(323),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/the_bishops_mill_durham.png"),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(18, 18),
                  color: Theme.of(context).shadowColor,
                  blurRadius: 30,
                ),
                BoxShadow(
                  offset: Offset(-18, -18),
                  color: Theme.of(context).colorScheme.secondary,
                  blurRadius: 30,
                ),
              ],
            ),
            child: Container(
              decoration: ShapeDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .background
                      .withOpacity(0.25),
                  shape: CircleBorder(
                      /*
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.background,
                          width: getSmallestSize(12),
                          style: BorderStyle.solid))),
                          */
                      )),
              child: Transform.rotate(
                angle: -pi / 2,
                child: CustomPaint(
                  painter: ClockPainter(context, _dateTime),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
