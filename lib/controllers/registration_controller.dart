import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webarts_assignment_gaurav/constants/global.dart';
import 'package:webarts_assignment_gaurav/model/register_response_model.dart';
import 'package:webarts_assignment_gaurav/utilities/email_validator.dart';
import 'package:webarts_assignment_gaurav/views/home_screen.dart';

class RegistrationController extends GetxController{
  Rx<TextEditingController> nameTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> emailTextEditingController = TextEditingController().obs;
  Rx<TextEditingController> passwordTextEditingController = TextEditingController().obs;

  RxBool isLoading = false.obs;

  validateFields(){
    isLoading(true);
    if(nameTextEditingController.value.text.length < 3){
      Get.snackbar("Error", "Invalid name");
    }
    else if(nameTextEditingController.value.text.length > 30){
      Get.snackbar("Error", "Too big name");
    }
    else if(emailTextEditingController.value.text.length < 8){
      Get.snackbar("Error", "Invalid email");
    }
    else if(!EmailValidator.validateEmail(emailTextEditingController.value.text)){
      Get.snackbar("Error", "Invalid email");
    }
    else if(passwordTextEditingController.value.text.length < 8){
      Get.snackbar("Error", "Password can't be less 8 characters");
    }
    else{
      //proceeding to registration process
      registerUserApiCall();
      
    }

    
  }

  registerUserApiCall()async{
    
    final _dio = dio.Dio();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    log("inside register api call");
    try{
      dio.Response response = await _dio.post("$baseUrl/v1/student",
      data: {
        "name": nameTextEditingController.value.text.trim(),
        "emailId": emailTextEditingController.value.text.trim(),
        "password": passwordTextEditingController.value.text.trim(),
      }
      );

    log(response.toString());
    
    if(response.statusCode == 200){
      if(response.data["success"] == 1){
        userRegistrationModel = RegisterResponseModel.fromJson(response.data);
        userName = userRegistrationModel!.data!.name;
        await prefs.setString('userName', userName ?? "");
    
      Future.delayed(const Duration(seconds: 1),(){
                      isLoading(false);
                      Get.off(() =>  HomeScreen());
                    },);
      
      }
      else{
        Get.snackbar("Error", "Something went wrong.");
        isLoading(false);
      }
    }
    else{
      Get.snackbar("Error", "Something went wrong.");
      isLoading(false);
    }
    }
    catch(e){
      Get.snackbar("Error", e.toString());
      isLoading(false);
    }

    

  }
}