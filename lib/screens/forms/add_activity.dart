import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guava/components/title_bar.dart';
import 'package:guava/models/trip.dart';
import 'package:guava/models/activity.dart';
import 'package:intl/intl.dart';
import 'package:guava/globals.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddActivity extends StatelessWidget {
  const AddActivity(this.trip);
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleBar(
              title: 'Add Activity',
              navBack: true,
            ),
            const SizedBox(height: 30),
            AddActivityForm(trip: trip),

          ]),
    );
  }
}

// Define a custom Form widget.
class AddActivityForm extends StatefulWidget {
  AddActivityForm({Key? key, required this.trip}) : super(key: key);

  Trip trip;

  String title = '';
  String description = '';
  String location = '';
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  num cost = 0;
  String notes = '';


  @override
  State<AddActivityForm> createState() => _AddActivityFormState();
}

class _AddActivityFormState extends State<AddActivityForm> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            padding: const EdgeInsets.only(top: 0, right: 30, left: 30, bottom: 30),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              Center(
                  child: Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover),
                    ),
                  )),
              const SizedBox(height: 20),
              Text(
                'Title',
                style: labelStyle(),
              ),
              TextFormField(
                  onChanged: (text) {
                    widget.title = text;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  maxLines: 1),
              const SizedBox(height: 20),
              Text(
                'Description',
                style: labelStyle(),
              ),
              TextFormField(
                  onChanged: (text) {
                    widget.description = text;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  maxLines: 1),
              const SizedBox(height: 20),
              Text(
                'Location',
                style: labelStyle(),
              ),
              TextFormField(
                  onChanged: (text) {
                    widget.location = text;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  maxLines: 1),
              const SizedBox(height: 20),
              Text(
                'Dates',
                style: labelStyle(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  startDate(),
                  startTime(),
                ],
              ),
              widget.startDate != null || widget.startTime != null ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  endDate(),
                  endTime(),
                ],
              ) : const SizedBox(height: 0),
              const SizedBox(height: 20),
              Text(
                'Cost',
                style: labelStyle(),
              ),
              TextFormField(
                onChanged: (text) {
                  widget.cost = int.parse(text);
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Text(
                'Notes',
                style: labelStyle(),
              ),
              TextFormField(
                  onChanged: (text) {
                    widget.notes = text;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  maxLines: 1),
              const SizedBox(height: 20),
              ElevatedButton(
                  child: const Text('Add Activity'),
                  onPressed: () {
                    trips[trips.indexWhere((t) => t.id == widget.trip.id)].addActivity(Activity(
                        title: widget.title,
                        description: widget.description,
                        image: 'placeholder.png',
                        location: widget.location,
                        startDate: widget.startDate,
                        endDate: widget.endDate,
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        cost: widget.cost,
                        notes: widget.notes,
                    ));
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xffF99258)),
                  )
              )

            ],
          ),
        )
    );
  }

  TextStyle labelStyle() {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
  }

  Widget startDate() {
    String startFormat = widget.startDate != null ? widget.startDate!.year == DateTime.now().year
        ? 'EEE, MMM dd'
        : 'EEE, MMM dd, yyyy'
        : "";

    return GestureDetector(
      onTap: () async {
        DateTime date = await _selectDate(context, null, widget.endDate);
        setState((){
          widget.startDate = date;
          widget.endDate == null ? widget.endDate = date : widget.endDate;
          widget.startTime = null;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top:20),
        child: widget.startDate != null ? Text(DateFormat(startFormat).format(widget.startDate!), style:TextStyle(fontSize: 17)) : Text("                                ", style: TextStyle(fontSize: 17, decoration: TextDecoration.underline, decorationColor: Theme.of(context).colorScheme.onSurface),)
      ),
    );
  }

  Widget endDate() {
    String startFormat = widget.endDate != null ? widget.endDate!.year == DateTime.now().year
        ? 'EEE, MMM dd'
        : 'EEE, MMM dd, yyyy'
        : "";

    return GestureDetector(
        onTap: () async {
          if (widget.startDate != null) {
            DateTime date = await _selectDate(context, widget.startDate, null);
            setState(() {
              widget.endDate = date;
              widget.endTime = null;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: widget.endDate != null ? Text(DateFormat(startFormat).format(widget.endDate!), style:TextStyle(fontSize: 17)) : Text("                                ", style: TextStyle(fontSize: 17, decoration: TextDecoration.underline, decorationColor: Theme.of(context).colorScheme.onSurface),)
        ),
    );
  }

  Widget startTime() {
    return GestureDetector(
        onTap: () async {
          TimeOfDay time = await _selectTime(context, null, widget.endTime);
          setState((){
            widget.startTime = time;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(top:20),
          child: widget.startTime != null
              ? Text(
              widget.startTime!.format(context),
              style: const TextStyle(
                fontSize: 17,
              )
          )
              : Text(
              "      :      ",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.transparent,
                  shadows: const [Shadow(offset: Offset(0, -10), color: Colors.black)],
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.onSurface
              )
          ),
        )
    );
  }

  Widget endTime() {
    return GestureDetector(
        onTap: () async {
          if (widget.startTime != null) {
            TimeOfDay time = await _selectTime(context, widget.startTime, null);
            setState(() {
              widget.endTime = time;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top:20),
          child: widget.endTime != null
              ? Text(
              widget.endTime!.format(context),
              style: const TextStyle(
                fontSize: 17,
              )
          )
              : Text(
              "      :      ",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.transparent,
                  shadows: const [Shadow(offset: Offset(0, -10), color: Colors.black)],
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.onSurface
              )
          ),
        )
    );
  }

  _selectDate(BuildContext context, start, end) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: start != null ? start : DateTime(DateTime.now().year - 5),
      lastDate: end != null ? end : DateTime(DateTime.now().year + 20),
      initialDate: start != null ? start : DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                  onSurface: const Color(0xff444444)
              ),
            ),
            child: child!,
          );
        }
    );
    if (picked != null) {
      return picked;
    } else {
      return null;
    }
  }

  _selectTime(BuildContext context, start, end) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (widget.startDate == widget.endDate && start != null ? (picked.hour * 60 + picked.minute) > (start.hour * 60 + start.minute) : true && end != null ? (picked.hour * 60 + picked.minute) < (end.hour * 60 + end.minute) : true) {
        return picked;
      } else {
        Fluttertoast.showToast(
          msg: 'Invalid Time'
        );
      }
    } else {
      return null;
    }
  }
}
