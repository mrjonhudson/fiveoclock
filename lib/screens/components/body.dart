import 'package:fiveoclock/screens/components/button.dart';
import 'package:flutter/material.dart';
import 'clock.dart';
import '../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      /*
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          image: DecorationImage(
            image: AssetImage("assets/images/the_bishops_mill_durham.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),

      Container(
        color: Color.fromRGBO(255, 255, 255, 0.75),
      ),
      */
      Container(
        child: SizedBox(
          width: getProportionateScreenWidth(414),
          height: getProportionateScreenHeight(896),
          child: Column(
            children: [
              Clock(),
              Expanded(
                  child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: getProportionateScreenWidth(414 * 0.8)),
                      child: Button())),
              SizedBox(
                height: getProportionateScreenHeight(20),
                child: Text("Carpet of __",
                    style: Theme.of(context).textTheme.bodyText1),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
