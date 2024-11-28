import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_study_app/firebase_ref/loading_status.dart';
import 'package:flutter_study_app/firebase_ref/references.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus =
      LoadingStatus.loading.obs; //loading status is observable

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0
    final fireStore = FirebaseFirestore.instance;
    //the old code:
    //final manifestContent = await DefaultAssetBundle.of(Get.context!)
    //.loadString("AssestManifest.json");
    //final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    //final papersInAssets = manifestMap.keys
    //.where((path) =>
    //path.startsWith("assets/DB/papers") && path.contains(".json"))
    //.toList();
    //the new code:
    final AssetManifest manifestContent =
        await AssetManifest.loadFromAssetBundle(
            DefaultAssetBundle.of(Get.context!));
    final List<String> allAssets = manifestContent.listAssets();
    // load json file and print paths
    final List<String> papersInAssets = allAssets
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();
    List<QuestionPaperModel> questionPapers = [];

    //suggestion by chatchuta to make the json files uploading parrallel
    // Parallel processing: load and parse all JSON files concurrently
    //we will need to remove the previous line just before this comment
    //which declares the questionPapers list
    //List<QuestionPaperModel> questionPapers = await Future.wait(
    //papersInAssets.map((paper) async {
    //String stringPaperContent = await rootBundle.loadString(paper);
    //return QuestionPaperModel.fromJson(json.decode(stringPaperContent));
    //}),
    //);

    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
    }
    //print('Items number ${questionPapers[0].description}');

    var batch = fireStore.batch();

    for (var paper in questionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count": paper.questions == null ? 0 : paper.questions!.length
      });

      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id, questionId: questions.id);
        batch.set(questionPath, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var answer in questions.answers) {
          batch.set(questionPath.collection("answers").doc(answer.identifier),
              {"identifier": answer.identifier, "answer": answer.answer});
        }
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed; //1
  }
}
