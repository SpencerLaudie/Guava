import 'package:flutter/material.dart';

class Activity {
  String title;
  String description;
  String image;
  String location;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  num? cost;
  String? notes;

  Activity({required this.title, this.description = '', required this.image, this.location = '',
    this.startDate, this.endDate, this.startTime, this.endTime, this.cost,
    this.notes});
}