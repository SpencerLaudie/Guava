import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guava/components/title_bar.dart';
import 'package:guava/models/trip.dart';

import '../globals.dart';

class BrowseItineraries extends StatefulWidget {

  const BrowseItineraries();

  @override
  State<BrowseItineraries> createState() => _BrowseItinerariesState();
}

class _BrowseItinerariesState extends State<BrowseItineraries> {
  Map<String, bool> filters = {
    "Outdoorsy": false,
    "Family": false,
    "Romantic": false,
    "Budget": false,
    "Camping": false
  };

  List<Trip> itineraries = trips.where((t) => t.public).toList();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
           const TitleBar(
            title: "Itineraries",
            navBack: true,
          ),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 10, right: 10.0, bottom: 10, left: 30),
                  width: MediaQuery.of(context).size.width - 60,
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: filters.length,
                    itemBuilder: (BuildContext context, int index) {
                      String key = filters.keys.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: _filter(key),
                      );
                    },

                  )
              ),
              Icon(Icons.filter_list_rounded),
            ]
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 10, right: 30, bottom: 20, left: 30),
              shrinkWrap: true,
              itemCount: itineraries.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {Navigator.pushNamed(context, '/itinerary', arguments: itineraries[index]);},
                    child: ItineraryCard(itinerary: itineraries[index]),
                  )
                );
              },
            )
          ),

        ]
      ),
    );
  }

  Widget _filter(String label) {
    return FilterChip(
      label: Text(label),
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      selected: filters[label]!,
      onSelected: (bool value) {
        setState(() {
          filters[label] = value;
        });
      },
      pressElevation: 0,
      backgroundColor: Color(0xffB5B5B5),
      selectedColor: Theme.of(context).colorScheme.primary,
      showCheckmark: false,
    );
  }

}

class ItineraryCard extends StatelessWidget {
  const ItineraryCard({Key? key, required this.itinerary}) : super(key: key);

  final Trip itinerary;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x88146a92),
                blurRadius: 15.0, // soften the shadow
                spreadRadius: -5.0, //extend the shadow
                offset: Offset(
                  00.0,
                  5.0,
                ),
              )
            ],
          ),
          child: Image(image: AssetImage("assets/images/trip-images/${itinerary.image}"), fit:BoxFit.cover)
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade500.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(itinerary.title, style: const TextStyle(color: Color(0xffffffff), fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Roboto'),),
                  SizedBox(height: 1),
                  itinerary.description != '' ? Text(itinerary.description, style: const TextStyle(color: Color(0xffffffff), fontSize: 16, fontFamily: 'Roboto'),) : const SizedBox(height: 0),
                  SizedBox(height: 5),
                  itinerary.location != '' ? Row(children: [Icon(Icons.person_pin_circle, color: Color(0xffffffff), size: 16), SizedBox(width: 5), Text(itinerary.location, style: const TextStyle(color: Color(0xffffffff), fontSize: 16, fontFamily: 'Roboto'))]) : const SizedBox(height: 0),
                ],
              ),
            )
          ),
        ),

      ]);
  }

}