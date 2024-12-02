import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: mainGradient(context)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 65),
            const SizedBox(height: 40),
            const Text(
              'تطبيق بيان لتعليم النحو العربي\nمحتوي: أ.اسلام صبيح\nتطوير التطبيق: احمد صبيح',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: onSurfaceTextColor,
                fontWeight: FontWeight.bold,
                height: 1.5, // Line height spacing
                fontFamily:
                    'Amiri', // Optional: Add an Arabic font for better appearance
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            AppCircleButton(
                onTap: () {
                  print("button clicked");
                  Get.offAndToNamed("/home");
                },
                child: const Icon(Icons.arrow_forward, size: 35))
          ],
        ),
      ),
    ));
  }
}
