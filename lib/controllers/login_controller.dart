import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webarts_assignment_gaurav/constants/global.dart';
import 'package:webarts_assignment_gaurav/model/login_response_model.dart';
import 'package:webarts_assignment_gaurav/utilities/email_validator.dart';
import 'package:webarts_assignment_gaurav/views/home_screen.dart';

class LoginController extends GetxController {
  Rx<TextEditingController> emailTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> passwordTextEditingController =
      TextEditingController().obs;

  RxBool isLoading = false.obs;

  validateFields() {
    isLoading(true);
    if (emailTextEditingController.value.text.length < 8) {
      Get.snackbar("Error", "Invalid email");
    } else if (!EmailValidator.validateEmail(
        emailTextEditingController.value.text)) {
      Get.snackbar("Error", "Invalid email");
    } else if (passwordTextEditingController.value.text.length < 8) {
      Get.snackbar("Error", "Password can't be less 8 characters");
    } else {
      //proceeding to login process
      registerUserApiCall();
    }
  }

  registerUserApiCall() async {
    final _dio = dio.Dio();
    final SharedPreferences prefs = await SharedPreferences.getInstance();



    log("inside login api call");
    try {
      dio.Response response =
          await _dio.post("$baseUrl/v1/student", data: {
        "emailId": emailTextEditingController.value.text.trim(),
        "password": passwordTextEditingController.value.text.trim(),
      });

      log(response.toString());

      if (response.statusCode == 200) {
        if (response.data["success"] == 1) {
          loginResponseModel = LoginResponseModel.fromJson(response.data);
          userName = loginResponseModel!.data!.name;
          // Save an String value to 'action' key.
            await prefs.setString('userName', userName ?? "");

          
          Future.delayed(const Duration(seconds: 1),(){
                      isLoading(false);
                      Get.off(() => HomeScreen());
                    },);
          
        } else {
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
