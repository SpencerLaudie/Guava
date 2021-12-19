import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guava/components/title_bar.dart';
import 'package:guava/models/trip.dart';
import 'package:intl/intl.dart';
import 'package:guava/globals.dart';

class CreateTrip extends StatelessWidget {
  const CreateTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleBar(
              title: 'Create Adventure',
              navBack: true,
            ),
            const SizedBox(height: 30),
            CreateTripForm(),

          ]),
    );
  }
}

// Define a custom Form widget.
class CreateTripForm extends StatefulWidget {
  CreateTripForm({Key? key}) : super(key: key);

  String title = '';
  String description = '';
  String location = '';
  DateTimeRange dates = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 7)));
  num budget = 0;

  @override
  State<CreateTripForm> createState() => _CreateTripFormState();
}

class _CreateTripFormState extends State<CreateTripForm> {

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
              const SizedBox(height:10),
              dateRange(),
              const SizedBox(height: 30),
              Text(
                'Budget',
                style: labelStyle(),
              ),
              TextFormField(
                onChanged: (text) {
                  widget.budget = int.parse(text);
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Create Trip'),
                onPressed: () {
                  trips.add(Trip(
                    title: widget.title,
                    description: widget.description,
                    image: 'placeholder.png',
                    location: widget.location,
                    dates: widget.dates,
                    budget: widget.budget
                  ));
                  Navigator.pop(context, trips);
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

  Widget dateRange() {
    String startFormat = widget.dates.start.year == DateTime.now().year
        ? 'MMM dd – '
        : 'MMM dd, yyyy – ';
    String endFormat = widget.dates.end.year == DateTime.now().year
        ? 'MMM dd'
        : 'MMM dd, yyyy';

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Row(
        children: [
          Text(DateFormat(startFormat).format(widget.dates.start), style:TextStyle(fontSize: 17)),
          Text(DateFormat(endFormat).format(widget.dates.end), style:TextStyle(fontSize: 17))
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 7))), // Refer step 1
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (picked != null) {
      setState(() {
        widget.dates = picked;
      });
    }
  }
}
