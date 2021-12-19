import 'package:flutter/material.dart';

class Lodging {
  String title;
  String image;
  String location;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  num? cost;
  String? notes;

  Lodging({required this.title, this.image='placeholder.png', this.location = '', this.startDate, this.endDate, this.startTime, this.endTime, this.cost, this.notes});
}