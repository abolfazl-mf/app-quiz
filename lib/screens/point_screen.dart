
import 'package:app_queiz/screens/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class PointScreen extends StatelessWidget {
  PointScreen({Key? key}) : super(key: key);
  String status = '';

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FutureBuilder(
            future: loadData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                List<String> resultlist = snapshot.data;

                return BodyMaker(resultlist);
              } //
              else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  BodyMaker(List<String> resultlist) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 40,
        ),
        Center(
            child: Image.asset(
          'asset/images/happy.png',
          width: 280,
        )),
        const Spacer(),
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
              color: Colors.white),
          height: 510,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Text(
                        'user',
                        style: TextStyle(fontSize: 29),
                      ),
                      Spacer(),
                      Icon(
                        Icons.check,
                        size: 40,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.check_box_outline_blank,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: resultlist.length,
                  itemBuilder: (context, index) {
                    String name = resultlist[index].split('/')[0];
                    int right = int.parse(resultlist[index].split('/')[1]);
                    int wrong = int.parse(resultlist[index].split('/')[2]);
                    int white = int.parse(resultlist[index].split('/')[3]);
                    if (right > wrong) {
                      status = 'w';
                    } //
                    else {
                      status = 'l';
                    }
                    return Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: 360,
                      height: 75,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            status == 'w' ? Colors.green : Colors.red,
                            Colors.white,
                          ],
                        ),
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(42)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 22),
                          ),
                          const Spacer(),
                          Text(
                            resultlist[index].split('/')[1],
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 29,
                          ),
                          Text(
                            resultlist[index].split('/')[2],
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            resultlist[index].split('/')[3],
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                        ],
                      ),
                    );
                    // return Center(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Text(resultlist[index].split('/')[0]),
                    //       Text(resultlist[index].split('/')[1]),
                    //       Text(resultlist[index].split('/')[2]),
                    //       Text(resultlist[index].split('/')[3]),
                    //     ],
                    //   ),
                    // );
                  },
                ),
                // Container(
                //   width: 360,
                //   height: 75,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [
                //         status == 'w' ? Colors.green : Colors.red,
                //         Colors.white,
                //       ],
                //     ),
                //     borderRadius:
                //         const BorderRadius.horizontal(left: Radius.circular(42)),
                //   ),
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                //   child: Row(
                //     children: [
                //       Text(
                //         name,
                //         style: const TextStyle(color: Colors.black, fontSize: 22),
                //       ),
                //       const Spacer(),
                //       Text(
                //         '${resultList[0]}',
                //         style: const TextStyle(
                //             color: Colors.green,
                //             fontSize: 38,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       const SizedBox(
                //         width: 29,
                //       ),
                //       Text(
                //         '${resultList[1]}',
                //         style: const TextStyle(
                //             color: Colors.red,
                //             fontSize: 38,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       const SizedBox(
                //         width: 25,
                //       ),
                //       Text(
                //         '${resultList[2]}',
                //         style: const TextStyle(
                //             color: Colors.grey,
                //             fontSize: 38,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       const SizedBox(
                //         width: 6,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<String>> loadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList('scores') ?? [];
  }

 


}
