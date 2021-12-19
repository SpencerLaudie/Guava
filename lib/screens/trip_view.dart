import 'package:flutter/material.dart';
import 'package:guava/models/trip.dart';
import 'package:guava/components/trip.dart';

enum Category {
  overview,
  activities,
  lodging,
  travel
}

class TripView extends StatefulWidget {
  final Trip trip;

  const TripView(this.trip);

  @override
  State<TripView> createState() => _TripViewState();
}

class _TripViewState extends State<TripView> {
  late Trip trip;
  int currCategory = 0;

  callback(category) {
    setState(() {
      currCategory = category;
    });
  }

  @override
  void initState() {
    trip = widget.trip;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TripHeader(title: trip.title, image: trip.image, callback: callback),
          TripContent(category: currCategory, trip: trip),

        ],
      ),
      floatingActionButton: getFAB(),
    );
  }

  FloatingActionButton? getFAB() {
    if (currCategory == 1) {
      return FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add-activity', arguments: widget.trip);
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xffF99258),
      );
    }
    if (currCategory == 2) {
      return FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add-lodging', arguments: widget.trip);
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xffF99258),
      );
    }
    return null;
  }
}