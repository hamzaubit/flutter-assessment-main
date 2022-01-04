import 'dart:convert';
import 'package:challenge_quiz/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'Widgets/widgets.dart';

class questionsSCreen extends StatefulWidget {
  @override
  _questionsSCreenState createState() => _questionsSCreenState();
}

class _questionsSCreenState extends State<questionsSCreen> {
  PageController _pageController = PageController(initialPage: 0);

  double score = 0.00;
  double myScore = 0.0;
  String? correctAnswer;
  var _items = [];
  var allAnswers = [];
  var combinedList = [];
  bool result = false;
  bool textColor = false;
  bool btnEnabled = false;
  double maxSCore = 70;
  int? _expandedIndex;
  bool quizCompleted = false;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
    print(_items);
    createNewList(0);
  }

  createNewList(int index) {
    if (index > 19) {
      setState(() {
        quizCompleted = true;
      });
    } else {
      correctAnswer = _items[index]['correct_answer'];
      var correctAnserList = [correctAnswer];
      print("Correct Answer : ${correctAnserList}");
      allAnswers = _items[index]['incorrect_answers'].cast<String>();
      combinedList = [
        allAnswers,
        correctAnserList,
      ].expand((x) => x).toList();
      print("Incorrect Answer : ${combinedList}");
      combinedList.shuffle();
      print("Incorrect Answer : ${combinedList}");
    }
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: quizCompleted
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Quiz Completed!",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal! * 8,
                        color: Colors.yellow),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 5,
                  ),
                  Text(
                    "Your Score : ${myScore.round()}% / 100%",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal! * 5,
                        color: Colors.lightGreen),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => questionsSCreen()));
                    },
                    child: Container(
                      color: Colors.yellow.withOpacity(0.5),
                      height: SizeConfig.blockSizeVertical! * 5,
                      width: SizeConfig.blockSizeHorizontal! * 50,
                      child: Center(
                          child: Text(
                        "Click To Start Again",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                            color: Colors.lightGreen),
                      )),
                    ),
                  ),
                ],
              ),
            )
          : PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                int count = index + 1;
                print(index);
                return Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: StepProgressIndicator(
                        totalSteps: 20,
                        currentStep: count,
                        selectedColor: Colors.black,
                        unselectedColor: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal! * 5,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Question ${count} of 20",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal! * 8),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal! * 5,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              _items[index]['category'],
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                  color: Colors.grey),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal! * 5,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: RatingBarIndicator(
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.black,
                            ),
                            itemCount: 5,
                            rating: _items[index]['difficulty'] == "hard"
                                ? 3
                                : _items[index]['difficulty'] == "medium"
                                    ? 2
                                    : 1,
                            itemSize: SizeConfig.blockSizeHorizontal! * 4.5,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal! * 5,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              _items[index]['type'],
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                  color: Colors.grey),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 3,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Center(
                          child: Text(
                        _items[index]['question'],
                        maxLines: 20,
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
                            color: Colors.black),
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      width: MediaQuery.of(context).size.width,
                      height: SizeConfig.blockSizeVertical! * 40,
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        children: List.generate(combinedList.length, (index) {
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _expandedIndex = index;
                                });
                                print(combinedList[index]);
                                if (combinedList[index] == correctAnswer) {
                                  setState(() {
                                    score += 0.05;
                                    result = true;
                                    btnEnabled = true;
                                    textColor = false;
                                    if (score > 1) {
                                      score = 1.00;
                                    }
                                    myScore = score * 100;
                                  });
                                } else {
                                  setState(() {
                                    result = false;
                                    btnEnabled = true;
                                    textColor = true;
                                  });
                                  print("Nothing...");
                                }
                              },
                              child: Container(
                                height: SizeConfig.blockSizeVertical! * 7,
                                width: SizeConfig.blockSizeHorizontal! * 40,
                                decoration: BoxDecoration(
                                  color: _expandedIndex == index
                                      ? Colors.yellow.withOpacity(0.5)
                                      : Colors.grey.withOpacity(0.5),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(
                                    child: Text(combinedList[index],
                                        style: TextStyle(
                                            fontSize: SizeConfig
                                                .blockSizeHorizontal! *
                                                3.5,
                                            color: Colors.black))),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 0.5,
                    ),
                    result
                        ? textConditionWidget("Correct!",result,textColor) :
                    textConditionWidget("Sorry!",result,textColor),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 0.5,
                    ),
                    this.btnEnabled
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                btnEnabled = false;
                                result = false;
                                textColor = false;
                                _expandedIndex = null;
                              });
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.decelerate);
                              combinedList.clear();
                              createNewList(count);
                            },
                            child: nextQuestionBtn(),

                          )
                        : SizedBox(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 4,
                    ),
                    myScoreWidget(myScore,maxSCore),
                    scoreProgressIndicator(score),
                  ],
                );
              }),
    );
  }
}

