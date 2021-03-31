import 'package:fiveoclock/screens/components/button.dart';
import 'package:flutter/material.dart';
import 'clock.dart';
import '../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center, // and bottomLeft
        child: SafeArea(
            child: Container(
                constraints: BoxConstraints(maxWidth: 588, minHeight: 485),
                padding: EdgeInsets.symmetric(horizontal: 37),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Clock(),
                          Expanded(
                              child: ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: getProportionateScreenWidth(
                                          414 * 0.8)),
                                  child: Button())),
                          SizedBox(
                            height: 20,
                            child: Text("Carpet of The Bishop's Mill, Durham",
                                style: Theme.of(context).textTheme.bodyText1),
                          )
                        ],
                      ),
                    ),
                  )
                ]))));
  }
}
