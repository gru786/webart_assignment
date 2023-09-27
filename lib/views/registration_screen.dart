import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webarts_assignment_gaurav/controllers/registration_controller.dart';
import 'package:webarts_assignment_gaurav/custom%20widgets/custom_button.dart';
import 'package:webarts_assignment_gaurav/custom%20widgets/custom_text_field.dart';
import 'package:webarts_assignment_gaurav/views/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final registrationController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                      textInputType: TextInputType.emailAddress,
                      validatorString: "Name",
                      controller: registrationController
                          .nameTextEditingController.value,
                      labelText: "Name"),
                  CustomTextField(
                      textInputType: TextInputType.emailAddress,
                      validatorString: "Email",
                      controller: registrationController
                          .emailTextEditingController.value,
                      labelText: "Email"),
                  CustomTextField(
                      validatorString: "Password",
                      textInputType: TextInputType.visiblePassword,
                      hideText: true,
                      controller: registrationController
                          .passwordTextEditingController.value,
                      labelText: "Password"),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        registrationController.validateFields();
                      }
                    },
                    child: Obx(
                      () => 
                      registrationController.isLoading.value ? const Center(child: CircularProgressIndicator.adaptive(),):
                      CustomButton(buttonText: "Register"),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => LoginScreen());
                        },
                        child: const Text(
                          "Login here",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
