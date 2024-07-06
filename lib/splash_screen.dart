import 'dart:async';

import 'package:flutter/material.dart';

import 'View/authScreens/login.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  initTimer() {
    Timer(const Duration(seconds: 3), () async{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (c)=> const MyLoginActivity()));
    });
  }

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("GreenMarket"),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/ic_launcher.png"
            ),
          ],
        ),
      ),
    );
  }
}
