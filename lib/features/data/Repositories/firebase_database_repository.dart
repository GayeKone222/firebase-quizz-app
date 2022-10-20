import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_study_app/features/data/firebase_ref/references.dart';
import 'package:firebase_study_app/features/domain/models/answer.dart';
import 'package:firebase_study_app/features/domain/models/auth_details_model.dart';
import 'package:firebase_study_app/features/domain/models/question_papers.dart';
import 'package:firebase_study_app/features/domain/models/questions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class RepositoryFireStoreDatabase {
  final FirebaseFirestore fireStore;

  RepositoryFireStoreDatabase({required this.fireStore});


  
  Future<bool> onUploadDB() async {
    try {
      // final fireStore = FirebaseFirestore.instance;

      final manifestContent = await rootBundle.loadString("AssetManifest.json");
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final papersInAssets = manifestMap.keys
          .where((path) =>
              path.startsWith("assets/DB/papers") && path.contains(".json"))
          .toList();

      //debugPrint(papersInAssets.toString());

      List<QuestionPapersModel> questionPapers = [];

      for (var paper in papersInAssets) {
        String stringPaperContent = await rootBundle.loadString(paper);

        questionPapers
            .add(QuestionPapersModel.fromJson(json.decode(stringPaperContent)));

        //debugPrint(stringPaperContent);
      }

      var batch = fireStore.batch();

      for (var paper in questionPapers) {
        batch.set(questionPaperRF.doc(paper.id), paper.toJson());

        for (var question in paper.questions) {
          var questionPath =
              questionRF(paperId: paper.id, questionId: question.id);
          batch.set(questionPath, question.toJson());

          for (var answer in question.answers) {
            batch.set(questionPath.collection("answers").doc(answer.identifier),
                answer.toJson());
          }
        }
      }

      await batch.commit();

      // print("Items number : ${questionPapers.length}");
      return true;
    } catch (e) {
      print("_onUploadDB error : $e");
      return false;
    }
  }

  Future<void> saveTestResults(
      {required AuthenticationDetailModel user,
      required QuestionPapersModel questionPapers}) async {
    var batch = fireStore.batch();

    if (user == null) return;

    batch.set(
        userRF
            .doc(user.uid)
            .collection("my-recent-test")
            .doc(questionPapers.id),
        {
          "points": 10,
          "correct_answers": "4/5",
          "question_id": questionPapers.id,
          "time": 20
        });
    await batch.commit();
  }

  Future<String?> _getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }

    try {
      Reference urlRef = firebaseStorage
          .child("question_paper_images")
          .child("${imgName.toLowerCase()}.png");

      var imgUrl = await urlRef.getDownloadURL();

      return imgUrl;
    } catch (e) {
      return null;
    }
  }

  Future<List<QuestionPapersModel>?> getAllPapers() async {
    //List<String> imgNames = ["biology", "chemistry", "maths", "physics"];
    // List<String> allPapersImages = [];
    List<QuestionPapersModel> allPapers = [];

    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      //convert document into model
      final paperList = data.docs.map((paper) {
        print("paper : ${paper.data()}");
        return QuestionPapersModel.fromSnapshot(paper);
      }).toList();
      allPapers.addAll(paperList);

      //get images

      for (var paper in allPapers) {
        final String? imgUrl = await _getImage(paper.title);

        if (imgUrl != null) {
          // allPapersImages.add(imgUrl);
          paper.imageUrl = imgUrl;
        } else {
          break;
        }
      }

      return allPapers.isEmpty ? null : allPapers;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<void> storeUser({required AuthenticationDetailModel user}) async {
    try {
      var batch = fireStore.batch();

      batch.set(userRF.doc(user.uid), user.toJson());
      await batch.commit();
    } catch (e) {
      if (kDebugMode) {
        print('enable to store user to firestore');
      }
    }
  }

  Future<List<QuestionsModel>?> getAllQuestions(
      {required QuestionPapersModel questionPapersModel}) async {
    try {
      List<QuestionsModel> allQuestions = [];

      //get questions collections
      final QuerySnapshot<Map<String, dynamic>> questionsQuery =
          await questionPaperRF
              .doc(questionPapersModel.id)
              .collection("questions")
              .get();
      final questions = questionsQuery.docs
          .map((e) => QuestionsModel.fromSnapshot(e))
          .toList();

      questionPapersModel.questions = questions;

      //get answers collections
      for (QuestionsModel question in questions) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPapersModel.id)
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();

        final answers =
            answersQuery.docs.map((e) => AnswersModel.fromSnapshot(e)).toList();
        //QuestionsModel newQuestion = question.copyWith(answers: answers);
        //question = newQuestion;
        question.answers = answers;
      }

      //assign all to a list
      allQuestions.addAll(questionPapersModel.questions);

      return allQuestions;
    } catch (e) {
      if (kDebugMode) {
        print("getAllQuestions from firebase error : $e");
      }

      return null;
    }
  }
}
