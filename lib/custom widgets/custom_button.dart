import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;

  const CustomButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.pinkAccent]),
                    ),
                    child:  Center(child: Text(buttonText, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),
                  );
  }
}