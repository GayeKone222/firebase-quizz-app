import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';

class QuestionPapersModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<QuestionsModel> questions;
  int questionCount;

  QuestionPapersModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.timeSeconds,
    required this.questions,
    required this.questionCount,
  });

  QuestionPapersModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['Description'],
        timeSeconds = json['time_seconds'],
        questionCount = 0,
        questions = List<QuestionsModel>.from(
            json['questions'].map((e) => QuestionsModel.fromJson(e)));

  QuestionPapersModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['Description'],
        questionCount = json['questions_count'] as int,
        timeSeconds = json['time_seconds'],
        questions = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['Description'] = description;
    data['time_seconds'] = timeSeconds;
    data['questions_count'] = questions.length;
    // data['questions'] = questions.map((v) => v.toJson()).toList();
    return data;
  }

  String timeInMinutes() => "${(timeSeconds / 60).ceil()} mins";
}
