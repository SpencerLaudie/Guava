import 'package:flutter/material.dart';
import 'package:guava/routes.dart';

import 'globals.dart';
import 'models/friend.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    trips[0].addFriend(Friend(firstName: "Matt", lastName: "Bomer", avatar: "matt.jpg"));

    return MaterialApp(
      title: 'Guava',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xff21bfe1),
          primaryVariant: Color(0xff146a92),
          secondary: Color(0xfff99258),
          secondaryVariant: Color(0xfff47c38),
          surface: Color(0xffffffff),
          background: Color(0xffffffff),
          error: Color(0xffffffff),
          onPrimary: Color(0xffffffff),
          onSecondary: Color(0xffffffff),
          onSurface: Color(0xffc4c4c4),
          onBackground: Color(0xffc4c4c4),
          onError: Color(0xffffffff),
          brightness: Brightness.light,
        )
      ),
      initialRoute: '/',
      routes: routes,
    );
  }
}


