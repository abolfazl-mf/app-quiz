import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomBottom extends StatelessWidget {
  const CustomBottom({Key? key, required this.text, required this.color, required this.onTap, required this.width}) : super(key: key);
final String text;
final Color color;
final VoidCallback onTap;
final double width;
  @override
  Widget build(BuildContext context) {
      return Material(
        borderRadius: BorderRadius.circular(25),
        color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onTap,
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 29,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }
  }

