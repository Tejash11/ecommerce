import 'package:flutter/material.dart';
import 'dart:async'; // Needed for Future and delay

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds before navigating to another screen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login_page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7, // Set width to 70% of screen
          height: MediaQuery.of(context).size.height * 0.7, // Set height to 70% of screen
          child: Image.asset(
            'assets/images/splashscreen.png', // Your splash image
            fit: BoxFit.contain, // Ensure the image fits within the defined box
          ),
        ),
      ),
    );
  }
}
