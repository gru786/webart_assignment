import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webarts_assignment_gaurav/controllers/login_controller.dart';
import 'package:webarts_assignment_gaurav/custom%20widgets/custom_button.dart';
import 'package:webarts_assignment_gaurav/custom%20widgets/custom_text_field.dart';
import 'package:webarts_assignment_gaurav/views/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());

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
                  const SizedBox(height: 50,),
                  CustomTextField(
                      textInputType: TextInputType.emailAddress,
                      validatorString: "Email",
                      controller: loginController.emailTextEditingController.value,
                      labelText: "Email"),
                  CustomTextField(
                      validatorString: "Password",
                      textInputType: TextInputType.visiblePassword,
                      hideText: true,
                      controller:
                          loginController.passwordTextEditingController.value,
                      labelText: "Password"),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        loginController.validateFields();
                      }
                    },
                    child: Obx(()=> loginController.isLoading.value ? const Center(child: CircularProgressIndicator.adaptive(),): CustomButton(buttonText: "Login")),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account. ",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => RegistrationScreen());
                        },
                        child: const Text(
                          "Register here",
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
