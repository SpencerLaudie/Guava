import 'package:flutter/material.dart';
import 'package:guava/models/trip.dart';

import 'models/activity.dart';

int id = 0;
int getTripId() {
  id++;
  return id;
}


List<Trip> trips = [
  Trip(
    title: 'Trip to Glacier NP',
    description: 'an epic trip to glacier',
    image: 'glacier.jpg',
    dates: DateTimeRange(start: DateTime(2021,11,20), end: DateTime(2021,12,17)),
    location: 'glacier',
    budget: 100,
    public: true,
    // activities: [
    //   Activity(
    //     title: "Hike",
    //     description: "20 mile hike for fun",
    //     image: "iceland.jpg",
    //     location: "glacier",
    //     startDate: DateTime(2021,12,15),
    //     endDate: DateTime(2021,12,15),
    //     startTime: TimeOfDay(hour: 15,minute: 00),
    //     endTime: TimeOfDay(hour: 17,minute: 00),
    //     cost: 0,
    //     notes: "remember to pack water"
    //   ),
    //   Activity(
    //       title: "Swim",
    //       description: "Swim in lake",
    //       image: "iceland.jpg",
    //       location: "glacier",
    //       cost: 0,
    //       notes: "don't drown"
    //   )
    // ]
  ),
  Trip(
    title: 'Let\'s go to Iceland',
    description: 'an epic trip to iceland',
    image: 'iceland.jpg',
    dates: DateTimeRange(start: DateTime(2022,11,20), end: DateTime(2022,12,17)),
    location: 'iceland',
    budget: 1000,
    public: false
  ),
  Trip(
    title: 'Catch me in Fiji',
    description: 'an epic trip to fiji',
    image: 'fiji.jpg',
    dates: DateTimeRange(start: DateTime(2021,12,20), end: DateTime(2021,12,31)),
    location: 'fiji',
    budget: 2000,
    public: true,
  ),
  Trip(
    title: 'Viagem para o Rio',
    description: 'an epic trip to rio',
    image: 'rio.jpg',
    dates: DateTimeRange(start: DateTime(2022,05,20), end: DateTime(2022,06,02)),
    location: 'rio',
    budget: 1000,
    public: true,
  ),
  Trip(
    title: 'Machu Picchu!!!',
    description: 'an epic trip to peru',
    image: 'machu-picchu.jpg',
    dates: DateTimeRange(start: DateTime(2020,11,20), end: DateTime(2020,12,17)),
    location: 'peru',
    budget: 50,
    public: false,
  ),
  Trip(
    title: 'Family Reunion 2021',
    description: 'an epic trip to the smokies',
    image: 'smoky-mountains.jpg',
    dates: DateTimeRange(start: DateTime(2019,11,20), end: DateTime(2019,12,17)),
    location: 'smokies',
    budget: 90,
    public: true,
  )
];

