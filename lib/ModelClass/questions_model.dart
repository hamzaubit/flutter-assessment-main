class QuestionsModel {
  String? category;
  String? type;
  String? difficulty;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  QuestionsModel({
      this.category, 
      this.type, 
      this.difficulty, 
      this.question, 
      this.correctAnswer, 
      this.incorrectAnswers});

  QuestionsModel.fromJson(dynamic json) {
    category = json["category"];
    type = json["type"];
    difficulty = json["difficulty"];
    question = json["question"];
    correctAnswer = json["correct_answer"];
    incorrectAnswers = json["incorrect_answers"] != null ? json["incorrect_answers"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category"] = category;
    map["type"] = type;
    map["difficulty"] = difficulty;
    map["question"] = question;
    map["correct_answer"] = correctAnswer;
    map["incorrect_answers"] = incorrectAnswers;
    return map;
  }

}