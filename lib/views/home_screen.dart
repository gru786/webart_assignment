import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webarts_assignment_gaurav/constants/global.dart';
import 'package:webarts_assignment_gaurav/controllers/home_controller.dart';
import 'package:webarts_assignment_gaurav/custom%20widgets/custom_button.dart';
import 'package:webarts_assignment_gaurav/views/login_screen.dart';
import 'package:webarts_assignment_gaurav/views/otp_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());
  late SharedPreferences prefs;

  initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
     userName = prefs.getString('userName');
  }
  @override
  void initState()  {
    initSharedPref();
    super.initState();
     
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Form(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcom ${userName!.toUpperCase()}",
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            Obx(
              () => homeController.isLoggingOff.value
                  ? const CircularProgressIndicator.adaptive()
                  : InkWell(
                      onTap: () async{
                        userRegistrationModel = null;
                        loginResponseModel = null;
                        userName = null;
                        await prefs.remove('counter');
                        homeController.isLoggingOff(true);
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            homeController.isLoggingOff(false);
                            Get.off(() => LoginScreen());
                          },
                        );
                      },
                      child: const CustomButton(buttonText: "Logout"),
                    ),
            ),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Text(
                  "Since I could not find any API of sending otp in the doc, there's just otp verification API, therefore I am putting a button here to see OTP Screen."),
            ),

             SizedBox(height: MediaQuery.sizeOf(context).height * 0.2,),
            InkWell(
              onTap: () {
                
                Get.to(()=>  OtpScreen());
              },
              child: const CustomButton(buttonText: "Go to OTP screen"),
            ),
          ],
        ),
      )),
    );
  }
}
