import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guava/models/trip.dart';
import 'package:guava/models/activity.dart';

// class MyTripsContainer extends StatefulWidget {
//   const MyTripsContainer({Key? key}) : super(key: key);
//
//   @override
//   State<MyTripsContainer> createState() => _MyTripsContainerState();
// }
//
// class _MyTripsContainerState extends State<MyTripsContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return const MyTripsNav();
//   }
// }

class MyTripsNav extends StatefulWidget {
  const MyTripsNav({Key? key, required this.trips}) : super(key: key);

  final List<Trip> trips;

  @override
  State<MyTripsNav> createState() => _MyTripsNavState();
}

class _MyTripsNavState extends State<MyTripsNav> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> myTripNavTabs = <Tab>[
    const Tab(text: 'Active'),
    const Tab(text: 'Upcoming'),
    const Tab(text: 'Past')
  ];

  late List<Trip> activeTrips;
  late List<Trip> upcomingTrips;
  late List<Trip> pastTrips;

  // <MyTripsItem>[
  //   MyTripsItem(trip: Trip(
  //       title: 'Trip to Glacier NP',
  //       description: 'an epic trip to glacier',
  //       image: 'glacier.jpg',
  //       dates: DateTimeRange(start: DateTime(2021,11,20), end: DateTime(2021,12,17)),
  //       // startDate: DateTime(2021,11,20),
  //       // endDate: DateTime(2021,12,17),
  //       location: 'glacier',
  //       budget: 100,
  //     )
  //   ),
  // ];

  // List<MyTripsItem> upcomingTrips = <MyTripsItem>[
  //   MyTripsItem(trip: Trip(
  //     title: 'Let\'s go to Iceland',
  //     description: 'an epic trip to iceland',
  //     image: 'iceland.jpg',
  //     dates: DateTimeRange(start: DateTime(2021,11,20), end: DateTime(2021,12,17)),
  //     // startDate: DateTime(2021,11,20),
  //     // endDate: DateTime(2021,12,17),
  //     location: 'iceland',
  //     budget: 1000,
  //     )
  //   ),
  //   MyTripsItem(trip: Trip(
  //       title: 'Catch me in Fiji',
  //       description: 'an epic trip to fiji',
  //       image: 'fiji.jpg',
  //       dates: DateTimeRange(start: DateTime(2021,11,20), end: DateTime(2021,12,17)),
  //       // startDate: DateTime(2021,11,20),
  //       // endDate: DateTime(2021,12,17),
  //       location: 'fiji',
  //       budget: 2000,
  //     )
  //   ),
  // ];
  //
  // List<MyTripsItem> pastTrips = <MyTripsItem>[
  //   MyTripsItem(trip: Trip(
  //       title: 'Viagem para o Rio',
  //       description: 'an epic trip to rio',
  //       image: 'rio.jpg',
  //       dates: DateTimeRange(start: DateTime(2021,11,20), end: DateTime(2021,12,17)),
  //       // startDate: DateTime(2021,11,20),
  //       // endDate: DateTime(2021,12,17),
  //       location: 'rio',
  //       budget: 1000,
  //     )
  //   ),
  //   MyTripsItem(trip: Trip(
  //     title: 'Machu Picchu!!!',
  //     description: 'an epic trip to peru',
  //     image: 'machu-picchu.jpg',
  //     dates: DateTimeRange(start: DateTime(2021,11,20), end: DateTime(2021,12,17)),
  //     // startDate: DateTime(2021,11,20),
  //     // endDate: DateTime(2021,12,17),
  //     location: 'peru',
  //     budget: 50,
  //   )
  //   ),
  //   MyTripsItem(trip: Trip(
  //       title: 'Family Reunion 2021',
  //       description: 'an epic trip to the smokies',
  //       image: 'smoky-mountains.jpg',
  //       dates: DateTimeRange(start: DateTime(2021,11,20), end: DateTime(2021,12,17)),
  //       // startDate: DateTime(2021,11,20),
  //       // endDate: DateTime(2021,12,17),
  //       location: 'smokies',
  //       budget: 90,
  //     )
  //   ),
  // ];



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    activeTrips = widget.trips.where((t) => t.dates.start.isBefore(DateTime.now()) && t.dates.end.isAfter(DateTime.now())).toList();
    upcomingTrips = widget.trips.where((t) => t.dates.start.isAfter(DateTime.now())).toList();
    pastTrips = widget.trips.where((t) => t.dates.end.isBefore(DateTime.now())).toList();
    return Column(

      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 30,
            top: 30
          ),
          height: 40,
          width: 350,
          child: TabBar(
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(color: Color(0xff21BFE1), width: 2)
            ),
            controller: _tabController,
            tabs: myTripNavTabs,
            isScrollable: true,
            labelPadding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 0,
              top: 10
            ),
            labelColor: const Color(0xff21BFE1),
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            unselectedLabelColor: const Color(0xffB5B5B5),
          )
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 30
          ),
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(top:20,bottom:20),
                physics: const BouncingScrollPhysics(),
                itemCount: activeTrips.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return MyTripsItem(trip: activeTrips[index]);
                }
              ),
              ListView.builder(
                  padding: const EdgeInsets.only(top:20,bottom:20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: upcomingTrips.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return MyTripsItem(trip: upcomingTrips[index]);
                  }
              ),
              ListView.builder(
                  padding: const EdgeInsets.only(top:20,bottom:20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: pastTrips.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return MyTripsItem(trip: pastTrips[index]);
                  }
              )
            ],
          )
        )
      ],
    );
  }
}

class MyTripNavItem extends StatefulWidget {
  const MyTripNavItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyTripNavItem> createState() => _MyTripNavItemState();
}

class _MyTripNavItemState extends State<MyTripNavItem> {
  @override
  Widget build(BuildContext context) {
    return Text(
        widget.title,
        style: const TextStyle(
          color: Color(0xffb5b5b5),
          fontSize: 17,
        )
    );
  }
}

class MyTripsItem extends StatefulWidget {
  const MyTripsItem({required this.trip});

  final Trip trip;

  @override
  State<MyTripsItem> createState() => _MyTripsItemState();
}

class _MyTripsItemState extends State<MyTripsItem> {
  late Trip trip;
  late String bgImage;
  late String title;

  @override
  void initState() {
    trip = widget.trip;
    bgImage = trip.image;
    title = trip.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/trip', arguments: trip);
      },
      child: Column(
        children: [
          Center(
            child: Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x88146a92),
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: -5.0, //extend the shadow
                      offset: Offset(
                        00.0,
                        10.0,
                      ),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/trip-images/$bgImage'), fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,style: const TextStyle(color: Color(0xffffffff), fontSize: 20, fontWeight: FontWeight.w600, fontFamily: 'Roboto'),),
                    ]
                  )
                )
            ),
          )
        ],
      ),
    );
  }
}