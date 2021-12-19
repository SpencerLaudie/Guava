import 'package:flutter/material.dart';
import 'package:guava/models/trip.dart';

class Itinerary extends StatelessWidget {
  const Itinerary(this.itinerary, {Key? key}) : super(key: key);

  final Trip itinerary;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(child: Text(itinerary.title))
    );
  }

}