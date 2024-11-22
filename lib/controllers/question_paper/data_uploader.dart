import 'dart:convert';

import 'package:flutter/material.dart';
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

  Future<void> uploadData() async {
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

    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
    }
    //print('Items number ${questionPapers[0].description}');

    var batch = fireStore.batch();
  }
}
