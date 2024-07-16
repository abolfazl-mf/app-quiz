import 'package:flutter/material.dart';
import 'package:app_queiz/constants.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kLightBlueBackgroundColor,
            kDarkBlueBackgroundColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
