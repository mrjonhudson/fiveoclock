import 'package:fiveoclock/screens/components/body.dart';
import 'package:fiveoclock/size_config.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // we have to call this on our starting page
    precacheImage(
        AssetImage("assets/images/the_bishops_mill_durham.png"), context);
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
