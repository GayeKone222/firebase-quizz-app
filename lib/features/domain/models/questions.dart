import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_study_app/features/domain/models/answer.dart';

class QuestionsModel extends Equatable {
  String id;
  String question;
  List<AnswersModel> answers;
  String correctAnswer;

  QuestionsModel(
      {required this.id,
      required this.question,
      required this.answers,
      required this.correctAnswer});

  QuestionsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers = List<AnswersModel>.from(
            json['answers'].map((x) => AnswersModel.fromJson(x))),
        correctAnswer = json['correct_answer'];

  QuestionsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        question = json['question'],
        correctAnswer = json['correct_answer'],
        answers = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    //data['answers'] = answers.map((v) => v.toJson()).toList();
    data['correct_answer'] = correctAnswer;
    return data;
  }

  @override
  List<Object?> get props => [id, question, answers, correctAnswer];
}
