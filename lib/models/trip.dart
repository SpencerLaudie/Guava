import 'package:flutter/material.dart';
import 'package:guava/models/activity.dart';
import 'package:guava/models/lodging.dart';
import 'package:guava/models/friend.dart';
import 'package:guava/globals.dart';

class Trip {
  int id = getTripId();
  String title;
  String description;
  String image;
  DateTimeRange dates;
  // DateTime startDate;
  // DateTime endDate;
  String location;
  num budget;
  bool public;
  List<Activity> activities = [];
  List<Lodging> lodging = [];
  List<Friend> friends = [];

  Trip({required this.title, this.description = '', this.image = 'default.jpg',
    required this.dates, this.location = '', this.budget = 0.0, this.public = false});

  void addActivity(Activity activity) {
    activities.add(activity);
  }

  void addLodging(Lodging lodge) {
    lodging.add(lodge);
  }

  void addFriend(Friend friend) {
    friends.add(friend);
  }

}