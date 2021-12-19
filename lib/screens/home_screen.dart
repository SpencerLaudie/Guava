import 'package:flutter/material.dart';
import 'package:guava/components/title_bar.dart';
import 'package:guava/components/my_trips.dart';
import 'package:guava/models/trip.dart';
import 'package:guava/globals.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Trip> theTrips = trips;

    final List<Widget> _home = [
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row (children: const [TitleBar(title: 'My Adventures'),]),
            Row(children: [MyTripsNav(trips: theTrips),])
          ]
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row (children: const [TitleBar(title: 'My Profile'),]),
          //Padding(padding: EdgeInsets.all(30),child:Text("Friends"),),


          //Text("Public Trips"),
        ],
      )
    ];

    return Scaffold(
      body: Container(
        child: _home[_selectedIndex],
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/bg-map.png'), fit: BoxFit.cover)
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff21BFE1),
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      floatingActionButton: ExpandableFab(
        initialOpen: false,
        distance: 70.0,
        children: [
          ActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/create-trip');
              setState(() {});
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
          ActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/browse-itineraries');
              setState(() {});
            },
            icon: const Icon(Icons.search, color: Colors.white),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ); // This trailing comma makes auto-formatting nicer for build method
  }




}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    this.initialOpen,
    required this.distance,
    required this.children,
  }) : super(key: key);

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment(0,0.93),
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 45.0; i < count; i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: _toggle,
            child: const Icon(Icons.landscape),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: MediaQuery.of(context).size.width * .45 + offset.dx,
          bottom: MediaQuery.of(context).size.height * .07 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconTheme.merge(
        data: const IconThemeData(),
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    Key? key,
    required this.isBig,
  }) : super(key: key);

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      height: isBig ? 128.0 : 36.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.shade300,
      ),
    );
  }
}



// PopupMenuButton<int>(
//   offset: Offset(-50, -130),
//   padding: EdgeInsets.zero,
//   elevation: 0,
//   itemBuilder: (context) => [
//     const PopupMenuItem(
//       value: 1,
//       child: Text(
//         "Browse Itineraries",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//             color: Colors.black, fontWeight: FontWeight.w700, ),
//       ),
//     ),
//     const PopupMenuItem(
//       value: 2,
//       child: Text(
//         "Create Trip",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//             color: Colors.black, fontWeight: FontWeight.w700),
//       ),
//     ),
//   ],
//   iconSize: 65,
//   icon: Container(
//     height: double.infinity,
//     width: double.infinity,
//     child: const Icon(Icons.add, color: Colors.white, size: 40),
//     decoration: ShapeDecoration(
//       shadows: [
//         BoxShadow(
//           blurRadius: 13.0,
//           color: Colors.grey.withOpacity(.8),
//           offset: const Offset(6.0, 6.0),
//         ),
//       ],
//       color: const Color(0xffF99258),
//       shape: const StadiumBorder(
//         side: BorderSide(color: Color(0xffF99258), width: 1),
//       )
//     ),
//   )
// ),

/*SpeedDial(
        icon: Icons.add,
        openCloseDial: isDialOpen,
        childrenButtonSize: MediaQuery.of(context).size.width,
        backgroundColor: const Color(0xffF99258),
        overlayColor: Colors.grey,
        overlayOpacity: 0.5,
        spacing: 15,
        spaceBetweenChildren: 15,
        closeManually: true,
        children: [
          SpeedDialChild(
              elevation: 0,

              // labelWidget: Text('Create Trip', style: TextStyle(fontSize: 20)),
              backgroundColor: Color(0x00ffffff),
              shape: ContinuousRectangleBorder(),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text('Create Trip', style: TextStyle(fontSize: 20)),
              ),
              onTap: (){

              }
          )
        ],
      ),*/