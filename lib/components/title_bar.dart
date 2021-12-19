import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({Key? key, required this.title, this.navBack = false})
      : super(key: key);

  final String title;
  final bool navBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        navBack
            ? IconButton(
                padding: const EdgeInsets.only(top: 70, bottom: 30, left: 25),
                icon: const Icon(Icons.arrow_back_rounded, size: 35),
                onPressed: () => Navigator.pop(context),
                color: Colors.black,
              )
            : const SizedBox.shrink(),
        Container(
            child: Padding(
          padding: EdgeInsets.only(top: navBack ? 0 : 100, left: 30.0),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto')),
        )),
      ],
    );
  }
}
