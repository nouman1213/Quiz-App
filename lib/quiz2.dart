import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/const/text_style.dart';
import 'package:quiz_app/score.dart';
import 'package:quiz_app/services/api_services.dart';

import 'const/colors.dart';

class QuizScreen2 extends StatefulWidget {
  const QuizScreen2({Key? key}) : super(key: key);

  @override
  State<QuizScreen2> createState() => _QuizScreen2State();
}

class _QuizScreen2State extends State<QuizScreen2> {
  var seconds = 30;
  bool isTap = false;
  Timer? timer;
  var currentQuestionIndex = 0;
  late Future quiz;
  var isLoaded = false;
  var points = 0;

  var optionsList = [];
  var optionsColor = [
    purpleLight,
    purpleLight,
    purpleLight,
    purpleLight,
    purpleLight,
  ];
  resetColors() {
    optionsColor = [
      purpleLight,
      purpleLight,
      purpleLight,
      purpleLight,
      purpleLight,
    ];
  }

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else if (seconds == 0) {
          currentQuestionIndex++;
          seconds = 30;
          timer.cancel();
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [white, purple],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
          child: FutureBuilder(
            future: quiz,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data['results'];
                if (isLoaded == false) {
                  optionsList = data[currentQuestionIndex]["incorrect_answers"];
                  optionsList.add(data[currentQuestionIndex]["correct_answer"]);
                  optionsList.shuffle();
                  isLoaded = true;
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(50)),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.xmark,
                                    color: white,
                                  ))),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              headingText(
                                  text: seconds.toString(),
                                  color: white,
                                  size: 24),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  value: seconds / 30,
                                  color: white,
                                ),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: white),
                                borderRadius: BorderRadius.circular(12)),
                            child: TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  isTap = !isTap;
                                });
                              },
                              icon: Icon(CupertinoIcons.heart_fill,
                                  color: isTap ? Colors.red : Colors.white),
                              label: normalText(
                                  text: isTap ? 'Liked' : 'Like',
                                  color: white,
                                  size: 18),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 0),
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/quiz.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: normalText(
                              text:
                                  'Question no ${currentQuestionIndex + 1} of ${data.length}',
                              color: white,
                              size: 16)),
                      const SizedBox(height: 10),
                      headingText(
                          text: '${data[currentQuestionIndex]['question']}',
                          color: white,
                          size: 16),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: optionsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var answer =
                              data[currentQuestionIndex]['correct_answer'];

                          return InkWell(
                            onTap: () {
                              setState(() {
                                if (answer.toString() ==
                                    optionsList[index].toString()) {
                                  optionsColor[index] = Colors.green;

                                  points = points + 10;
                                } else {
                                  optionsColor[index] = Colors.red;
                                }

                                if (currentQuestionIndex < data.length - 1) {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    isLoaded = false;
                                    currentQuestionIndex++;
                                    resetColors();
                                    timer!.cancel();
                                    seconds = 30;
                                    startTimer();
                                  });
                                } else {
                                  timer!.cancel();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ScoreScreen(
                                              points: points.toString())));
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                width: size.width - 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: optionsColor[index]),
                                child: Center(
                                    child: headingText(
                                        text: optionsList[index].toString(),
                                        size: 16,
                                        color: white)),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(white)),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
