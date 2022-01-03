import 'package:challenge_quiz/questions.dart';
import 'package:challenge_quiz/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class questionsSCreen extends StatefulWidget {
  @override
  _questionsSCreenState createState() => _questionsSCreenState();
}

class _questionsSCreenState extends State<questionsSCreen> {

  PageController _pageController = PageController(initialPage: 0);

  double score = 0.00;
  double myScore = 0.0;
  String? correctAnswer;
  String? firstValue;
  String? secondValue;
  String? thirdValue;
  var allAnswers = [];
  var combinedLis = [];
  bool result = false;
  bool textColor = false;
  bool btnEnabled = false;
  double maxSCore = 70;
  int? _expandedIndex;
  bool quizCompleted = false;

  createNewList(int index){
    if(index > 19){
      print("AAAAAAAAAAAAAAAAAAAAAA");
      setState(() {
        quizCompleted = true;
      });
    }
    else{
      correctAnswer = questions[index]['correct_answer'];
      var correctAnserList = [correctAnswer];
      print("Correct Answer : ${correctAnserList}");
      allAnswers = questions[index]['incorrect_answers'].cast<String>();
      combinedLis = [allAnswers, correctAnserList,].expand((x) => x).toList();
      print("Incorrect Answer : ${combinedLis}");
      combinedLis.shuffle();
      print("Incorrect Answer : ${combinedLis}");
    }
  }

  @override
  void initState() {
    createNewList(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: quizCompleted ? Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("Quiz Completed!",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 8,color: Colors.yellow),),
            SizedBox(height: SizeConfig.blockSizeVertical! * 5,),
            Text("Your Score : ${myScore.round()}% / 100%",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 5,color: Colors.lightGreen),),
            SizedBox(height: SizeConfig.blockSizeVertical! * 5,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => questionsSCreen()));
              },
              child: Container(
                color: Colors.yellow,
                height: SizeConfig.blockSizeVertical! * 5,
                width: SizeConfig.blockSizeHorizontal! * 50,
                child: Center(child: Text("Click To Start Again",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 5,color: Colors.lightGreen),)),
              ),
            ),
          ],
        ),
      ) :
      PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: questions.length,
          itemBuilder: (context , index){
          int count = index + 1;
          print(index);
        return Column(
          children: [
            SizedBox(height: SizeConfig.blockSizeVertical! * 5,),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: StepProgressIndicator(
                totalSteps: 20,
                currentStep: count,
                selectedColor: Colors.black,
                unselectedColor: Colors.grey,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 5,),
            Row(
              children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 5,),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("Question ${count} of 20",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 8),))
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
            Row(
              children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 5,),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(questions[index]['category'],style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 4,color: Colors.grey),))
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
            Row(
              children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 5,),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: RatingBarIndicator(
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.black,
                    ),
                    itemCount: 5,
                    rating: questions[index]['difficulty'] == "hard" ? 3 : questions[index]['difficulty'] == "medium" ? 2 : 1,
                    itemSize: SizeConfig.blockSizeHorizontal! * 4.5,
                  ),)
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
            Row(
              children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 5,),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(questions[index]['type'],style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 4,color: Colors.grey),))
              ],
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 3,),
            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Center(child: Text(questions[index]['question'],maxLines: 20,style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 5.5,color: Colors.black),)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: MediaQuery.of(context).size.width,
              height: SizeConfig.blockSizeVertical! * 40,
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                children: List.generate(combinedLis.length, (index) {
                  return Center(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _expandedIndex = index;
                        });
                        print(combinedLis[index]);
                        if(combinedLis[index] == correctAnswer){
                          setState(() {
                            score += 0.05;
                            result = true;
                            btnEnabled = true;
                            textColor = false;
                            if(score > 1){
                              score = 1.00;
                            }
                            myScore = score * 100;
                          });
                        }
                        else{
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(child: Text(combinedLis[index],style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 3.5,color: Colors.black))),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 0.5,),
            result ? Text("Correct!",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 5.5,color: Colors.lightGreen)) :
            Text("Sorry!",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 5.5,color: textColor ? Colors.red : Colors.white)),
            SizedBox(height: SizeConfig.blockSizeVertical! * 0.5,),
            btnEnabled ?
            GestureDetector(
              onTap: (){
                setState(() {
                  btnEnabled = false;
                  result = false;
                  textColor = false;
                  _expandedIndex = null;
                });
                _pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.decelerate);
                combinedLis.clear();
                createNewList(count);
              },
              child: Center(
                child: Container(
                  height: SizeConfig.blockSizeVertical! * 5,
                  width: SizeConfig.blockSizeHorizontal! * 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(child: Text("Next Question",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 3.5,color: Colors.black))),
                ),
              ),
            ) : SizedBox(),
            SizedBox(height: SizeConfig.blockSizeVertical! * 4,),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Score : ${myScore.round()}%",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 3.5,color: Colors.black)),
                  myScore.round() >= 70 ? Text("Max Score : ${myScore.round()}",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 3.5,color: Colors.black)) :
                  Text("Max Score : ${maxSCore.round()}",style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 3.5,color: Colors.black))
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 3,),
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 20,
                  lineHeight: SizeConfig.blockSizeVertical! * 3.5,
                  percent: score,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.black,
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
