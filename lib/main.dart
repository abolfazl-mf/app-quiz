import 'package:app_queiz/constants.dart';
import 'package:app_queiz/screens/point_screen.dart';
import 'package:app_queiz/screens/result_screen.dart';
import 'package:app_queiz/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_queiz/model/questions_model.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Ubuntu'),
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Size size;
  bool isonePressed = true;
  ScrollController scrollController = ScrollController();
  int currentQuestionNumber = 0;
  List statusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < questionsList.length; i++) {
      statusList.add(0);
    }
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation = Tween(begin: 0.0, end: 1.0).animate(
        controller) //این توایین یعنی از چپ بره راست و کلا انیمیشن از 0 تا یک دهم داره
      ..addListener(() {
        setState(() {
          if ((animation.value * 100).round() >= 98) {
            onNextPressed(true);
            if (controller.isAnimating) {
              controller.reset();
              controller.forward();
            }
          }
        });
      });

    controller.forward(); //هی تکرار میکنه میره تا اخر و دوباره تکرار میکنه
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kLightBlueColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: animation.value,
                      backgroundColor: kLightBlueColor,
                      valueColor: const AlwaysStoppedAnimation(
                          Colors.white), //رنگ ولیو انیمیشن باید توی این باشه
                    ), //animation
                  ), //border radius for animation
                ),
                const SizedBox(
                  height: 23,
                ),
                questionlistRow(),
                SizedBox(
                  height: 516,
                  width: size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: size.width - 160,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: Container(
                          width: size.width - 110,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: size.width - 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.white,
                                Color(0xffA7D4ff),
                              ],
                              begin: Alignment.center,
                              end: Alignment.bottomLeft,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 70),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 146,
                              ),
                              SizedBox(
                                height: 105,
                                child: Text(
                                  questionsList[currentQuestionNumber]
                                      .questions,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: kDarkBlueColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  answerContainer(
                                      questionsList[currentQuestionNumber]
                                          .answer1,
                                      1),
                                  answerContainer(
                                      questionsList[currentQuestionNumber]
                                          .answer2,
                                      2),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        child: Image.asset(
                          questionsList[currentQuestionNumber].imageAddress,
                          width: 170,
                          height: 200,
                        ),
                        top: 27,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                //فضای بین دو چیز رو خودش تنظیم میکنه که چقدر بینشون فاصله بده
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: kNextButtonColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: InkWell(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        onTap: () {
                          onNextPressed(false);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                          ),
                          width: 222,
                          padding: const EdgeInsets.symmetric(vertical: 21),
                          child: const Center(
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 19, horizontal: 22),
                      decoration: const BoxDecoration(
                        color: kPurpleColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(33),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          myNavigator();
                        },
                        child: const Center(
                          child: Icon(
                            Icons.flag_circle_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ), //این برای اینه که چون اپ بار نداریم این و باید بزاریم تا اوکی کار کنه پروژه
      ),
    );
  }

  myNavigator() {
    controller.reset();
    controller.dispose();
    List<int> resultList = grader();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            resultList: resultList,
          ),
        ));
  }

  Widget questionlistRow() {
    List<Widget> list = [];
    for (int i = 0; i < questionsList.length; i++) {
      list.add(questionnumber(i + 1));
    }
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(children: list),
    );
  }

  Widget questionnumber(int num) {
    Color color1 = kLightBlueColor;
    int temp = num - 1;
    int size = questionsList.length;
    if (temp == currentQuestionNumber) {
      if (temp == size - 1 && statusList[temp] != 0) {
        if (statusList[temp] == true) {
          color1 = kLightGreenColor;
        } else if (statusList[temp] == false) {
          color1 = kLightRedColor;
        } else {}
      } //
      else {
        color1 = Colors.white;
      }
    } else {
      if (statusList[temp] == true) {
        color1 = kLightGreenColor;
      } else if (statusList[temp] == false) {
        color1 = kLightRedColor;
      } else {}
    }

    return Container(
      height: temp == currentQuestionNumber ? 80 : 60,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: temp == currentQuestionNumber ? 80 : 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color1,
      ),
      child: Center(
        child: Text(
          '$num',
          style: TextStyle(
              color: temp == currentQuestionNumber ? Colors.blue : Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void onNextPressed(bool IsFromTimer) {
    scrollController.animateTo(currentQuestionNumber * 70,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    if (IsFromTimer) {
      statusList[currentQuestionNumber] = false;
    } else {
      checkAnswer();
    }
    if (currentQuestionNumber >= 8) {
      myNavigator();
    } else {
      currentQuestionNumber++;
      print(currentQuestionNumber);
      setState(() {});
    }
  }

  Widget answerContainer(String aswer, int num) {
    return GestureDetector(
      onTap: () {
        if (num == 1) {
          setState(() {
            isonePressed = true;
          });
        } //
        else {
          setState(() {
            isonePressed = false;
          });
        }
      },
      child: Container(
        width: 144,
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
          BoxShadow(
              color: isonePressed && num == 1 || !isonePressed && num == 2
                  ? kPurpleShadowColor
                  : kBlueShadowColor,
              offset: const Offset(-4, -4)),
          BoxShadow(
            color: isonePressed && num == 1 || !isonePressed && num == 2
                ? kPurpleColor
                : kLightBlueColor,
          ),
        ]),
        child: Center(
          child: Text(
            aswer,
            style: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  checkAnswer() {
    int MyAnswer = isonePressed ? 1 : 2;
    bool status = questionsList[currentQuestionNumber].isRight(MyAnswer);
    statusList[currentQuestionNumber] = status;
    print(statusList);
  }

  List<int> grader() {
    int rightAnswer = 0;
    int wrongAnswer = 0;
    int whiteAnswer = 0;
    for (var item in statusList) {
      if (item == true) {
        rightAnswer++;
      } //
      else if (item == false) {
        wrongAnswer++;
      } else {
        whiteAnswer++;
      }
    }
    return [rightAnswer, wrongAnswer, whiteAnswer];
  }


}
