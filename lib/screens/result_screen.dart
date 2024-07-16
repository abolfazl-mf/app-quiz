import 'dart:io';

import 'package:app_queiz/screens/point_screen.dart';
import 'package:app_queiz/widget/custom_bottom.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({Key? key, required this.resultList}) : super(key: key);
  final List<int> resultList;
  TextEditingController Textcontroller = TextEditingController();
  String status = '';

  @override
  Widget build(BuildContext context) {
    if (resultList[0] > resultList[1]) {
      status = 'w';
    } //
    else{
      status = 'l';
    }

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 31,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          status == 'w' ? kLightGreenColor : kLightRedColor,
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 619,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 60,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  width: MediaQuery.of(context).size.width - 80,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(50),
                                      bottom: Radius.circular(50),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 180,
                                      ),
                                      Text(
                                        status == 'w'
                                            ? 'you are winner !'
                                            : 'you are loser',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: status == 'w'
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(
                                        height: 2,
                                        color: Colors.green,
                                        thickness: 3,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      pointRow(Icons.check, 'correct ',
                                          '${resultList[0]}', Colors.green),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      pointRow(Icons.close, 'wrong ',
                                          '${resultList[1]}', Colors.red),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      pointRow(
                                          Icons.check_box_outline_blank,
                                          'white ',
                                          '${resultList[2]}',
                                          Colors.grey),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  child: Image.asset(
                                    'asset/images/${status == 'w' ? 'winner.png' : 'loser.png'}',
                                    width: status == 'w' ? 280 : 157,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBottom(
                          text: 'Play again',
                          color: Colors.orangeAccent,
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Would you like to play again?',
                              desc: 'we like to reply 😘',
                              btnCancelText: 'No',
                              btnOkText: 'Yes',
                              btnCancelOnPress: () {
                                onNoPressed(context);
                              },
                              btnOkOnPress: () {
                                onYesPressed(context);
                              },
                            ).show();
                          },
                          width: 180),
                      CustomBottom(
                          text: 'Result',
                          color: Colors.white,
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              title: 'This is Ignored',
                              desc: 'This is also Ignored',
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO_REVERSED,
                              body: Column(
                                children: [
                                  TextField(
                                    controller: Textcontroller,
                                  ),
                                ],
                              ),
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                onOkpressed(context);
                              },
                            ).show();
                          },
                          width: 180),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget pointRow(IconData icon, String text, String point, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          size: 45,
          color: color,
        ),
        Text(
          text,
          style: TextStyle(
              color: color, fontSize: 36, fontWeight: FontWeight.bold),
        ),
        Text(
          point,
          style: TextStyle(
              color: color, fontSize: 38, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void onPlayAgainPressed(context) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedButton(
              text: 'Tab here',
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.QUESTION,
                  headerAnimationLoop: true,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Would you like to play again?',
                  desc: 'we like to reply 😘',
                  buttonsTextStyle:
                      const TextStyle(color: Colors.black, fontSize: 22),
                  btnCancelText: 'No',
                  btnOkText: 'Yes',
                  showCloseIcon: true,
                  btnCancelOnPress: () {
                    onNoPressed(context);
                  },
                  btnOkOnPress: () {
                    onYesPressed(context);
                  },
                ).show();
              },
            ),

            // const Text(
            //   'Would you like to play again?',
            //   style: TextStyle(
            //       fontSize:20,
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(
            //   height: 25,
            // ),
            // Row(
            //   children: [
            //     Expanded(child: myButton(text: 'Yes', color: kLightGreenColor, onTap: (){},width: 60)),
            //     const SizedBox(width: 20,),
            //     Expanded(child: myButton(text: 'No', color: kLightRedColor, onTap: (){},width: 60)),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  onYesPressed(context) {
    Phoenix.rebirth(context);
  }

  onNoPressed(context) {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } //
    else if (Platform.isIOS) {
      exit(0);
    } //
    else {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void onOkpressed(context) async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    List<String> list= pref.getStringList('scores')??[];
    list.add('${Textcontroller.text}/${resultList[0]}/${resultList[1]}/${resultList[2]}');
    await pref.setStringList('scores', list);
    pref.getStringList('scores');
    Navigator.push(context, MaterialPageRoute(builder: (context) => PointScreen(),),);
    Textcontroller.clear();
  }
}
