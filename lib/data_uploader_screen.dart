import 'package:flutter/material.dart';
import 'package:flutter_study_app/controllers/question_papers/data_uploader.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_study_app/firebase_ref/loading_status.dart';
import 'package:flutter_study_app/firebase_ref/loading_status.dart';
import 'package:get/get.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({super.key});
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Obx(() => Text(
          controller.loadingStatus.value == LoadingStatus.completed
              ? "Uploading completed"
              : "Uploading...")),
    ));
  }
}
