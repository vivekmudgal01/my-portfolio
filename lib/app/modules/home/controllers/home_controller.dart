import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {

  final String resumeUrl =
      "https://drive.google.com/file/d/12_KQNxIvsld5hU8Xwwx-7tI6BVxMn6n3/view?usp=sharing";

  Future<void> viewResume() async {
    final Uri url = Uri.parse(resumeUrl);

    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      Get.snackbar("Error", "Could not open resume");
    }
  }

  final String resumeDownloadUrl =
      "https://drive.google.com/uc?export=download&id=12_KQNxIvsld5hU8Xwwx-7tI6BVxMn6n3";

  Future<void> downloadResume() async {
    final Uri url = Uri.parse(resumeDownloadUrl);

    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      Get.snackbar("Error", "Could not download resume");
    }
  }
  Future<void> openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/918979917160?text=Hi Vivek, I want to work with you",
    );

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          "Error",
          "WhatsApp could not be opened",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: '52vivekmudgal@gmail.com',
      queryParameters: {
        'subject': 'Hire',
        'body': 'Hi Vivek, I want to work with you.',
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        Get.snackbar(
          "Error",
          "Email app not found",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> makeCall() async {
    final Uri callUri = Uri(
      scheme: 'tel',
      path: '8979917160',
    );

    try {
      if (await canLaunchUrl(callUri)) {
        await launchUrl(
          callUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        Get.snackbar(
          "Error",
          "Calling not supported",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}