import "package:flutter_study_app/firebase_ref/references.dart";
import "package:get/get.dart";

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage
          .child("question_paper_images")
          .child("${imgName.toLowerCase()}.png");
      print(
          "Fetching URL for: ${urlRef.fullPath}"); // Print the path being accessed
      var imgUrl = await urlRef.getDownloadURL();
      print(
          "Image URL fetched for $imgName: $imgUrl"); //to make sure the urls are returned
      return imgUrl;
    } catch (e) {
      print("Error fetching image for $imgName: $e");
      return null;
    }
  }
}
