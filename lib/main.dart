import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webarts_assignment_gaurav/constants/global.dart';
import 'package:webarts_assignment_gaurav/views/home_screen.dart';
import 'package:webarts_assignment_gaurav/views/login_screen.dart';

void main() async{

  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;

  String? userName;

  initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
     userName = prefs.getString('userName');
  }
  @override
  void initState()  {
    initSharedPref();
    super.initState();
     
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: userName == null || userName!.isEmpty ?   LoginScreen() : HomeScreen(),
    );
  }
}

