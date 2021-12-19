import 'package:flutter/widgets.dart';
import 'package:guava/screens/browse_itineraries.dart';
import 'package:guava/screens/forms/add_activity.dart';
import 'package:guava/screens/forms/add_lodging.dart';
import 'package:guava/screens/home_screen.dart';
import 'package:guava/screens/itinerary_view.dart';
import 'package:guava/screens/trip_view.dart';
import 'package:guava/models/trip.dart';
import 'package:guava/screens/forms/create_trip.dart';



final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomeScreen(title:'guava'),
  "/trip": (context) => TripView(ModalRoute.of(context)!.settings.arguments as Trip),
  "/create-trip": (BuildContext context) => const CreateTrip(),
  "/add-activity": (BuildContext context) => AddActivity(ModalRoute.of(context)!.settings.arguments as Trip),
  "/add-lodging": (BuildContext context) => AddLodging(ModalRoute.of(context)!.settings.arguments as Trip),
  "/browse-itineraries": (BuildContext context) => const BrowseItineraries(),
  "/itinerary": (BuildContext context) => Itinerary(ModalRoute.of(context)!.settings.arguments as Trip),
};