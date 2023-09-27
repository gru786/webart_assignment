import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:webarts_assignment_gaurav/controllers/otp_controller.dart';
import 'package:webarts_assignment_gaurav/custom%20widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
   OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
   String inputPin = "";
    final otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: OTPTextField(
                  controller: otpController.otpTextEditingController.value,
                  
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 80,
                  obscureText: true,
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                    setState(() {
                      inputPin  = pin;
                    });
                  },
                ),
              ),
              InkWell(
                onTap: (){
                  log("button clicked");
                  if(otpController.otpTextEditingController.value.isBlank ?? true){

                  }
                  else{

                  Get.snackbar("OTP", "You've entered $inputPin");
                  otpController.otpVerifyApiCall();
                  }
                },
                child: const CustomButton(buttonText: "Verify OTP"),),
                const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
