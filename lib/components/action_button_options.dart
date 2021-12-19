import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActionButtonOptions extends StatefulWidget {
  const ActionButtonOptions({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ActionButtonOptions> createState() => _ActionButtonOptionsState();
}

class _ActionButtonOptionsState extends State<ActionButtonOptions> {
  final double _value = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          PageView.builder(
              itemBuilder: (context, pos) {
                return Stack(
                  children: <Widget>[
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: _value, sigmaY: _value),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(_value)),
                      ),
                    )
                  ],
                );
              }
          )
        ]
        )
    );
  }
}

// PopupMenuButton<int>(
// padding: EdgeInsets.zero,
// elevation: 10,
// itemBuilder: (context) => [
// const PopupMenuItem(
// value: 1,
// child: Text(
// "Browse Itineraries",
// style: TextStyle(
// color: Colors.black, fontWeight: FontWeight.w700),
// ),
// ),
// const PopupMenuItem(
// value: 2,
// child: Text(
// "Create Trip",
// style: TextStyle(
// color: Colors.black, fontWeight: FontWeight.w700),
// ),
// ),
// ],
// iconSize: 65,
// icon: Container(
// height: double.infinity,
// width: double.infinity,
// child: const Icon(Icons.add, color: Colors.white, size: 40),
// decoration: ShapeDecoration(
// shadows: [
// BoxShadow(
// blurRadius: 13.0,
// color: Colors.grey.withOpacity(.8),
// offset: const Offset(6.0, 6.0),
// ),
// ],
// color: const Color(0xffF99258),
// shape: const StadiumBorder(
// side: BorderSide(color: Color(0xffF99258), width: 1),
// )
// ),
// )
// ),