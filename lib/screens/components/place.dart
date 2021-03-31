import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Place>> fetchPlaces(http.Client client) async {
  final response = await client.get(Uri.parse('data/cityMap.json'));

  // Use the compute function to run parsePlaces in a separate isolate.
  return compute(parsePlaces, response.body);
}

// A function that converts a response body into a List<Place>.
List<Place> parsePlaces(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Place>((json) => Place.fromJson(json)).toList();
}

class Place {
  final String city_ascii;
  final double lat;
  final double lng;
  final String country;
  final String province;
  final String timezone;
  final String state_ansi;

  Place(
      {this.city_ascii,
      this.lat,
      this.lng,
      this.country,
      this.province,
      this.timezone,
      this.state_ansi});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      city_ascii: json['city_ascii'] as String,
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      country: json['country'] as String,
      province: json['province'] as String,
      timezone: json['timezone'] as String,
      state_ansi: json['state_ansi'] as String,
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Place>>(
        future: fetchPlaces(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PlacesList(places: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PlacesList extends StatelessWidget {
  final List<Place> places;

  PlacesList({Key key, this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return Text(places[index].city_ascii);
      },
    );
  }
}
