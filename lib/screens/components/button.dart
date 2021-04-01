import 'dart:async';
import 'dart:math';
//import 'dart:io';

import 'package:fiveoclock/models/my_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timezone/tzdata.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'clock_painter.dart';
import 'dart:convert';
import 'package:share/share.dart';

import 'package:timezone/timezone.dart';
import 'package:flutter/services.dart';

import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:snack/snack.dart';
import 'package:clipboard/clipboard.dart';

Random rnd = new Random();

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  String _city = "Getting data...";
  String _country = "Please wait";
  String _state;
  String oldPlace;
  int state;
  DateTime currentTime;
  DateTime fivePM;
  bool invisible = true;

  List _items = [];
  List _allCities = [];
  List _bigCities = [];
  List _timezones = [];

  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  SnackBar bar;

  // Fetch content from the json file
  readJson() async {
    final String response = await rootBundle.loadString('data/cityMap.json');
    final data = await json.decode(response);
    setState(() {
      _timezones = getTimeZones(data);
      _allCities = filterCities(data, _timezones);
      _bigCities = filterSmallCities(_allCities);
      _items = _allCities;
      changeText();
    });
  }

  Future<void> setupTZs() async {
    var byteData = await rootBundle.load('packages/timezone/data/2020d.tzf');
    initializeDatabase(byteData.buffer.asUint8List());
  }

  List getTimeZones(dynamic data) {
    List tzs = [];
    dynamic _locations = timeZoneDatabase.locations;
    for (dynamic tz in _locations.values) {
      DateTime tzTime =
          new TZDateTime.from(currentTime, getLocation(tz.toString()));

      int difference = (int.parse(tzTime.hour.toString())) - 17;
      if (difference == 0) {
        //print(tz.toString());
        tzs.add(tz.toString());
      }
    } //);
    return tzs;
  }

  List filterCities(dynamic data, List timezones) {
    List places = [];
    for (dynamic place in data) {
      for (dynamic tz in timezones) {
        if ((tz.toString()) == (place["timezone"].toString())) {
          places.add(place);
        }
      }
      //print(place["city_ascii"]);

    }
    return places;
  }

  List filterSmallCities(dynamic cities) {
    List bigPlaces = [];
    for (dynamic place in cities) {
      if (place["pop"] > 1000000) {
        print(place["pop"]);
        bigPlaces.add(place);
      }
    }
    return bigPlaces;
  }

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _fadeInFadeOut = Tween<double>(begin: 1, end: 0).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        changeText();
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //animation.forward();
      }
    });
    setupTZs();
    readJson();
    // Open Main page
    setState(() {
      state = 0;
      currentTime = DateTime.now();
      fivePM = new DateTime(
          currentTime.year, currentTime.month, currentTime.day, 17);
      bar = SnackBar(content: Text('Hello, world!'));
    });
  }

  void handleAsync() async {
    // Wait for async to complete
  }

  changeText() {
    setState(() {
      dynamic placeNew;
      do {
        int r = rnd.nextInt(_items.length);
        placeNew = _items[r];
        print(placeNew);
      } while (placeNew["city_ascii"] == oldPlace || _items.length == 1);
      _city = placeNew["city_ascii"];
      (placeNew["state_ansi"] != null)
          ? _country = placeNew["province"] + ", " + placeNew["iso3"]
          : _country = placeNew["country"];
      oldPlace = placeNew["city_ascii"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /*
        SizedBox(
          height: getProportionateScreenHeight(72),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(_city, style: Theme.of(context).textTheme.headline1),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(42),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(_country, style: Theme.of(context).textTheme.headline4),
          ),
        ),

        Text(_items[index]["city_ascii"])
        */
        // Display the data loaded from sample.json
        SizedBox(
            height: getProportionateScreenHeight(100),
            child: FittedBox(
              fit: BoxFit.contain,
              child: GestureDetector(
                  onTap: () {
                    if ((state % 2) == 0) {
                      if (_bigCities.length > 1) {
                        bar = new SnackBar(
                          content: Text('Switched to cities.',
                              style: Theme.of(context).textTheme.bodyText2),
                          backgroundColor:
                              Theme.of(context).primaryIconTheme.color,
                          behavior: SnackBarBehavior.floating,
                        );
                        _items = _bigCities;
                      }
                    } else {
                      bar = new SnackBar(
                        content: Text('Switched to all places.',
                            style: Theme.of(context).textTheme.bodyText2),
                        backgroundColor:
                            Theme.of(context).primaryIconTheme.color,
                        behavior: SnackBarBehavior.floating,
                      );
                      _items = _allCities;
                    }
                    bar.show(context);
                    state++;
                  },
                  child: FadeTransition(
                      opacity: _fadeInFadeOut,
                      child: Text(_city,
                          key: Key('3'),
                          style: Theme.of(context).textTheme.headline1))),
            )),
        SizedBox(
          height: getProportionateScreenHeight(42),
          child: FittedBox(
              fit: BoxFit.contain,
              child: FadeTransition(
                  opacity: _fadeInFadeOut,
                  child: Text(_country,
                      key: Key('3'),
                      style: Theme.of(context).textTheme.headline1))),
        ),
        Expanded(child: Container()),
        Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: getSmallestSize(57),
                    width: getSmallestSize(57),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
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
                      child: IconButton(
                        padding: new EdgeInsets.all(0.0),
                        color: Theme.of(context).primaryIconTheme.color,
                        icon: new Icon(Icons.map, size: getSmallestSize(25)),
                        onPressed: () {
                          print("Container clicked");
                          MapsLauncher.launchQuery(_city + ", " + _country);
                        },
                      ),
                    )),
                Container(
                  width: min(150, getProportionateScreenWidth(40)),
                ),
                SizedBox(
                    height: getSmallestSize(77),
                    width: getSmallestSize(77),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
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
                      child: IconButton(
                        padding: new EdgeInsets.all(0.0),
                        color: Theme.of(context).accentIconTheme.color,
                        icon: new Icon(Icons.local_bar,
                            size: getSmallestSize(45)),
                        onPressed: () {
                          animation.forward();
                        },
                      ),
                    )),
                Container(
                  width: min(150, getProportionateScreenWidth(40)),
                ),
                SizedBox(
                  height: getSmallestSize(57),
                  width: getSmallestSize(57),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
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
                    child: IconButton(
                        padding: new EdgeInsets.all(0.0),
                        color: Theme.of(context).primaryIconTheme.color,
                        icon: new Icon(Icons.share, size: getSmallestSize(25)),
                        onPressed: () {
                          if (kIsWeb) {
                            // running on the web!
                            FlutterClipboard.copy('OMG! It\'s five o\'clock in ' +
                                    _city +
                                    '! That means we can start drinking now!! Check for yourself at https://fiveoclock-62362.web.app/!')
                                .then((value) => print('copied'));
                            bar = new SnackBar(
                              content: Text('Copied to clipboard!',
                                  style: Theme.of(context).textTheme.bodyText2),
                              backgroundColor:
                                  Theme.of(context).primaryIconTheme.color,
                              behavior: SnackBarBehavior.floating,
                            );
                            bar.show(context);
                          } else {
                            Share.share('OMG! It\'s five o\'clock in ' +
                                _city +
                                '! That means we can start drinking now!! Check for yourself at https://fiveoclock-62362.web.app/!');
                          }
                        }),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
