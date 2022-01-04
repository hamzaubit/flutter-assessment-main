import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../sizeConfig.dart';

class textConditionWidget extends StatelessWidget {

  String? text;
  bool? color;
  bool? textColor;
  textConditionWidget(this.text,this.color,this.textColor);

  @override
  Widget build(BuildContext context) {
    return Text(this.text!,
        style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
            color: this.color! ? Colors.lightGreen : this.textColor! ? Colors.red : Colors.white));
  }
}

class nextQuestionBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: SizeConfig.blockSizeVertical! * 5,
        width: SizeConfig.blockSizeHorizontal! * 40,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
            child: Text("Next Question",
                style: TextStyle(
                    fontSize: SizeConfig
                        .blockSizeHorizontal! *
                        3.5,
                    color: Colors.black))),
      ),
    );
  }
}

class myScoreWidget extends StatelessWidget {

  double? myScore;
  double? maxScore;
  myScoreWidget(this.myScore,this.maxScore);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Score : ${this.myScore!.round()}%",
              style: TextStyle(
                  fontSize:
                  SizeConfig.blockSizeHorizontal! * 3.5,
                  color: Colors.black)),
          this.myScore!.round() >= 70
              ? Text("Max Score : ${this.myScore!.round()}",
              style: TextStyle(
                  fontSize:
                  SizeConfig.blockSizeHorizontal! * 3.5,
                  color: Colors.black))
              : Text("Max Score : ${this.maxScore!.round()}",
              style: TextStyle(
                  fontSize:
                  SizeConfig.blockSizeHorizontal! * 3.5,
                  color: Colors.black))
        ],
      ),
    );
  }
}

class scoreProgressIndicator extends StatelessWidget {

  double? score;

  scoreProgressIndicator(this.score);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: SizeConfig.blockSizeHorizontal! * 3,
        ),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 20,
          lineHeight: SizeConfig.blockSizeVertical! * 3.5,
          percent: this.score!,
          backgroundColor: Colors.grey,
          progressColor: Colors.black,
        ),
      ],
    );
  }
}
