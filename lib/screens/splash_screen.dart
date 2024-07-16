import 'dart:async';



import 'dart:js';
import 'package:flutter/material.dart';

import 'package:app_queiz/constants.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _splashscreen();
  }
}

class _splashscreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orangeAccent,
            Colors.greenAccent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child:  Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Image.asset('asset/images/flow.png'),
            const Text('''try to be your best
                     verrrrrrrsion''',style: TextStyle(fontSize: 39,fontWeight: FontWeight.bold),),
            const SizedBox(height: 50,),
            const CircularProgressIndicator(),
          ],
        ),

      ),
    );
  }
}

Future<Timer> loadData() async {
  return Timer(const Duration(seconds: 5), onDoneLoading(context));
}

onDoneLoading(context) async {
  await Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
}
