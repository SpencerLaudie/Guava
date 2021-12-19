import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guava/guava_icons.dart';
import 'package:guava/models/friend.dart';
import 'package:guava/models/lodging.dart';
import 'package:guava/models/trip.dart';
import 'package:guava/models/activity.dart';
import 'package:intl/intl.dart';

class TripHeader extends StatefulWidget {
  final String title;
  final String image;
  Function(int) callback;

  TripHeader(
      {Key? key,
      required this.title,
      required this.image,
      required this.callback})
      : super(key: key);

  @override
  State<TripHeader> createState() => _TripHeaderState();
}

class _TripHeaderState extends State<TripHeader> {
  int category = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .5,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/trip-images/${widget.image}'),
              fit: BoxFit.cover),
        ),
        padding:
            const EdgeInsets.only(top: 50, right: 20, bottom: 100, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded, size: 35),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            ),
            Text(widget.title,
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Roboto')),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 55, minHeight: 45),
                  onPressed: () {
                    setState(() {
                      category = 0;
                    });
                    widget.callback(0);
                  },
                  elevation: 2.0,
                  fillColor:
                      category == 0 ? const Color(0x8879DFFF) : Colors.white54,
                  child: const Icon(GuavaIcons.info,
                      color: Color(0x5e000000), size: 20),
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 55, minHeight: 45),
                  onPressed: () {
                    setState(() {
                      category = 1;
                    });
                    widget.callback(1);
                  },
                  elevation: 2.0,
                  fillColor:
                      category == 1 ? const Color(0x8879DFFF) : Colors.white54,
                  child: const Icon(GuavaIcons.kayak,
                      color: Color(0x5e000000), size: 18),
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 55, minHeight: 45),
                  onPressed: () {
                    setState(() {
                      category = 2;
                    });
                    widget.callback(2);
                  },
                  elevation: 2.0,
                  fillColor:
                      category == 2 ? const Color(0x8879DFFF) : Colors.white54,
                  child: const Icon(GuavaIcons.bed,
                      color: Color(0x5e000000), size: 17),
                  padding: const EdgeInsets.only(top: 10.0, right: 13, bottom: 10, left: 7),
                  shape: const CircleBorder(),
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 55, minHeight: 45),
                  onPressed: () {
                    setState(() {
                      category = 3;
                    });
                    widget.callback(3);
                  },
                  elevation: 2.0,
                  fillColor:
                      category == 3 ? const Color(0x8879DFFF) : Colors.white54,
                  child: const Icon(GuavaIcons.plane,
                      color: Color(0x5e000000), size: 18),
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                ),
              ],
            )
          ],
        ));
  }
}

class TripContent extends StatefulWidget {
  int category;
  Trip trip;

  TripContent({Key? key, required this.category, required this.trip})
      : super(key: key);

  @override
  State<TripContent> createState() => _TripContentState();
}

class _TripContentState extends State<TripContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: .6,
        minChildSize: .6,
        maxChildSize: .85,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: getCategory(widget.category, scrollController));
        });
  }

  Widget getCategory(int category, ScrollController controller) {
    switch (category) {
      case 0:
        return overview(controller);
      case 1:
        return activities(controller);
      case 2:
        return lodging(controller);
      case 3:
        return travel(controller);
      default:
        return const Center(child: Text("an error has occurred"));
    }
  }

  Widget overview(ScrollController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left:20.0,right:20),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle:
              NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                  snap: true,
                  pinned: true,
                  floating: true,
                  titleSpacing: 0,
                  automaticallyImplyLeading: false,
                  foregroundColor: Colors.black,
                  backgroundColor: Color(0xffffffff),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Overview',
                        style: titleStyle(),
                      ),

                    ],
                  )))
          ];
        },
        body: ListView(
          padding: const EdgeInsets.only(top: 120, bottom: 20),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          controller: controller,
          children: [
            Text(
              'Description',
              style: subtitleStyle(),
            ),
            TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
              ),
              scrollPhysics: const BouncingScrollPhysics(),
              maxLines: 1,
              initialValue: widget.trip.description,
            ),
            const SizedBox(height: 20),
            Text(
              'Dates',
              style: subtitleStyle(),
            ),
            SizedBox(height: 10),
            dateRange(),
            const SizedBox(height: 30),
            Text(
              'Friends',
              style: subtitleStyle(),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.trip.friends.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: _friend(widget.trip.friends[index]),
                        );
                      },

                    )
                ),
                RawMaterialButton(
                  constraints: const BoxConstraints(minWidth: 55, minHeight: 45),
                  onPressed: () {},
                  elevation: 0.0,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(Icons.add,
                      color: Colors.white, size: 20),
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Budget',
              style: subtitleStyle(),
            ),
            TextFormField(
              initialValue: widget.trip.budget.toString(),
              keyboardType: TextInputType.number,
            )
          ],
        ),
      ),
    );
  }

  Widget activities(ScrollController controller) {
    List<Activity> plannedActivities =
        widget.trip.activities.where((act) => act.startDate != null).toList();
    List<Activity> savedActivities =
        widget.trip.activities.where((act) => act.startDate == null).toList();
    plannedActivities.sort((a, b) => a.startDate!.compareTo(b.startDate!));
    int currDate = 0;
    bool planned = plannedActivities.isNotEmpty || savedActivities.isEmpty;
    TabController _tabController =
        TabController(initialIndex: planned ? 0 : 1, length: 2, vsync: this);

    return Padding(
      padding: const EdgeInsets.only(top: 5, left:20.0,right:20),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  snap: true,
                    pinned: true,
                    floating: true,
                    titleSpacing: 0,
                    automaticallyImplyLeading: false,
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xffffffff),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Activities',
                          style: titleStyle(),
                        ),
                        TabBar(
                          indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  color: Color(0xff21BFE1), width: 2)),
                          controller: _tabController,
                          tabs: const [Text('Planned'), Text('Saved')],
                          isScrollable: true,
                          labelPadding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
                          labelColor: const Color(0xff21BFE1),
                          labelStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          unselectedLabelColor: const Color(0xffB5B5B5),
                        )
                      ],
                    )))
          ];
        },
        body: TabBarView(controller: _tabController,
            // These are the contents of the tab views, below the tabs.
            children: [

              ListView.builder(
                controller: controller,
                padding: const EdgeInsets.only(top: 120, bottom: 20),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: plannedActivities.length,
                itemBuilder: (BuildContext context, int index) {
                  bool newDate = index == 0 ? true : false;
                  if (index == 0) {
                    currDate = plannedActivities[index].startDate!.day;
                  }
                  if (plannedActivities[index].startDate!.day != currDate) {
                    currDate = plannedActivities[index].startDate!.day;
                    newDate = true;
                  }
                  return activity(plannedActivities[index], true, newDate);
                },
              ),
              ListView.builder(
                controller: controller,
                padding: const EdgeInsets.only(top: 120, bottom: 20),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: savedActivities.length,
                itemBuilder: (BuildContext context, int index) {
                  return activity(savedActivities[index], false, false);
                },
              ),
            ]),
      ),
    );
  }

  Widget lodging(ScrollController controller) {
    List<Lodging> plannedLodging =
    widget.trip.lodging.where((lod) => lod.startDate != null).toList();
    List<Lodging> savedLodging =
    widget.trip.lodging.where((lod) => lod.startDate == null).toList();
    plannedLodging.sort((a, b) => a.startDate!.compareTo(b.startDate!));
    int currDate = 0;
    bool planned = plannedLodging.isNotEmpty || savedLodging.isEmpty;
    TabController _tabController =
    TabController(initialIndex: planned ? 0 : 1, length: 2, vsync: this);

    return Padding(
      padding: const EdgeInsets.only(top: 5, left:20.0,right:20),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                    snap: true,
                    pinned: true,
                    floating: true,
                    titleSpacing: 0,
                    automaticallyImplyLeading: false,
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xffffffff),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Lodging',
                          style: titleStyle(),
                        ),
                        TabBar(
                          indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  color: Color(0xff21BFE1), width: 2)),
                          controller: _tabController,
                          tabs: const [Text('Planned'), Text('Saved')],
                          isScrollable: true,
                          labelPadding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
                          labelColor: const Color(0xff21BFE1),
                          labelStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          unselectedLabelColor: const Color(0xffB5B5B5),
                        )
                      ],
                    )))
          ];
        },
        body: TabBarView(controller: _tabController,
            // These are the contents of the tab views, below the tabs.
            children: [

              ListView.builder(
                controller: controller,
                padding: const EdgeInsets.only(top: 120, bottom: 20),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: plannedLodging.length,
                itemBuilder: (BuildContext context, int index) {
                  bool newDate = index == 0 ? true : false;
                  if (index == 0) {
                    currDate = plannedLodging[index].startDate!.day;
                  }
                  if (plannedLodging[index].startDate!.day != currDate) {
                    currDate = plannedLodging[index].startDate!.day;
                    newDate = true;
                  }
                  return lodge(plannedLodging[index], true, newDate);
                },
              ),
              ListView.builder(
                controller: controller,
                padding: const EdgeInsets.only(top: 120, bottom: 20),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: savedLodging.length,
                itemBuilder: (BuildContext context, int index) {
                  return lodge(savedLodging[index], false, false);
                },
              ),
            ]),
      ),
    );
  }

  Widget travel(ScrollController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Travel',
            style: titleStyle(),
          ),
          SizedBox(height: 100),
          const Center(
            child: Text("coming soon")
          )
        ]
      ),
    );
  }

  Widget activity(Activity act, bool planned, bool newDate) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column (
        children: [
          newDate ? Row(children: [Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Text(DateFormat('MMM dd').format(act.startDate!), style:subtitleStyle()),
          )]) : const SizedBox.shrink(),
          Row(children: [
            planned
                ? const SizedBox.shrink()
                : const CircleAvatar(
                child: Icon(Icons.add, size: 18, color: Colors.white),
                radius: 13,
                backgroundColor: Color(0xffF99258)),
            planned ? const SizedBox.shrink() : const SizedBox(width: 10),
            Container(
              width: planned ? 150 : 130,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/activity-images/${act.image}')),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    act.title,
                    style: subtitleStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  act.location != ''
                      ? Row(children: [
                    const Icon(Icons.person_pin_circle, size: 17),
                    const SizedBox(width: 5),
                    Flexible(
                        child: Text(act.location,
                            maxLines: 1, overflow: TextOverflow.ellipsis))
                  ])
                      : const SizedBox.shrink(),
                  const SizedBox(height: 6),
                  act.startTime != null
                      ? Row(children: [
                          const Icon(Icons.access_time_filled_rounded, size: 17),
                          const SizedBox(width: 5),
                          Flexible(
                              child: Text(act.endTime != null ? "${act.startTime!.format(context)} - ${act.endTime!.format(context)}" : act.startTime!.format(context),
                                  maxLines: 1, overflow: TextOverflow.ellipsis))
                      ])
                      : const SizedBox.shrink(),
                ]))
          ]),
        ]
      )
    );
  }

  Widget lodge(Lodging lod, bool planned, bool newDate) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column (
            children: [
              newDate ? Row(children: [Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(DateFormat('MMM dd').format(lod.startDate!), style:subtitleStyle()),
              )]) : const SizedBox.shrink(),
              Row(children: [
                planned
                    ? const SizedBox.shrink()
                    : const CircleAvatar(
                    child: Icon(Icons.add, size: 18, color: Colors.white),
                    radius: 13,
                    backgroundColor: Color(0xffF99258)),
                planned ? const SizedBox.shrink() : const SizedBox(width: 10),
                Container(
                  width: planned ? 150 : 130,
                  height: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/lodging-images/${lod.image}')),
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                    child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(
                        lod.title,
                        style: subtitleStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      lod.location != ''
                          ? Row(children: [
                        const Icon(Icons.person_pin_circle, size: 17),
                        const SizedBox(width: 5),
                        Flexible(
                            child: Text(lod.location,
                                maxLines: 1, overflow: TextOverflow.ellipsis))
                      ])
                          : const SizedBox.shrink(),
                      const SizedBox(height: 6),
                      lod.startTime != null
                          ? Row(children: [
                        const Icon(Icons.access_time_filled_rounded, size: 17),
                        const SizedBox(width: 5),
                        Flexible(
                            child: Text(lod.endTime != null ? "${lod.startTime!.format(context)} - ${lod.endTime!.format(context)}" : lod.startTime!.format(context),
                                maxLines: 1, overflow: TextOverflow.ellipsis))
                      ])
                          : const SizedBox.shrink(),
                    ]))
              ]),
            ]
        )
    );
  }

  TextStyle plannedNavStyle(bool planned) {
    return TextStyle(
      color: planned ? const Color(0xff21BFE1) : const Color(0xffb5b5b5),
    );
  }

  TextStyle titleStyle() {
    return const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: Color(0xff4B4B4B),
    );
  }

  TextStyle subtitleStyle() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Color(0xff4B4B4B),
    );
  }

  Widget dateRange() {
    String startFormat = widget.trip.dates.start.year == DateTime.now().year
        ? 'MMM dd – '
        : 'MMM dd, yyyy – ';
    String endFormat = widget.trip.dates.end.year == DateTime.now().year
        ? 'MMM dd'
        : 'MMM dd, yyyy';

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Row(
        children: [
          Text(DateFormat(startFormat).format(widget.trip.dates.start), style: TextStyle(fontSize: 17)),
          Text(DateFormat(endFormat).format(widget.trip.dates.end), style: TextStyle(fontSize: 17))
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: widget.trip.dates, // Refer step 1
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (picked != null && picked != widget.trip.dates) {
      setState(() {
        widget.trip.dates = picked;
      });
    }
  }

  Widget _friend(Friend friend) {
    return Column(
      children: [
        Container(
          width:45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(image: AssetImage("assets/images/avatars/${friend.avatar}"), fit: BoxFit.cover)
          ),
        ),
        Text("${friend.firstName}",
          style: TextStyle(),
        ),
      ],
    );
  }
}

