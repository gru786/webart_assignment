import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:otp_text_field/otp_text_field.dart';
import 'package:webarts_assignment_gaurav/constants/global.dart';
import 'package:webarts_assignment_gaurav/controllers/login_controller.dart';
import 'package:webarts_assignment_gaurav/controllers/registration_controller.dart';
import 'package:webarts_assignment_gaurav/views/home_screen.dart';

class OtpController extends GetxController{
  var otpTextEditingController = OtpFieldController().obs;
  RxBool isLoading = false.obs;

  otpVerifyApiCall() async {
    final _dio = dio.Dio();

    var loginController = Get.put(LoginController());
    var registerController = Get.put(RegistrationController());
    

    String? email;
    if(loginController.emailTextEditingController.value.text.isNotEmpty){
      email = loginController.emailTextEditingController.value.text.trim();
    }
    else if(registerController.emailTextEditingController.value.text.isNotEmpty){
      email = registerController.emailTextEditingController.value.text.trim();
    }

    log("inside otp verify api call");
    try {
      dio.Response response =
          await _dio.patch("$baseUrl/v1/student/opt/verification", data: {
        "emailId": email ?? "dummyMail",
        "otp": otpTextEditingController.value.toString(),
      });

      log(response.toString());

      if (response.statusCode == 200) {
        if (response.data["success"] == 1) {
         
          
          Future.delayed(const Duration(seconds: 1),(){
                      isLoading(false);
                      Get.off(() => HomeScreen());
                    },);
          
        } else {
          isLoading(false);
          Get.snackbar("Error", response.data["message"]);
        }
      } else {
        Get.snackbar("Error", "Something went wrong.");
        isLoading(false);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      isLoading(false);
    }
  }
}