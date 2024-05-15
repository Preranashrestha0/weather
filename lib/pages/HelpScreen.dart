import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapi/pages/HomePageScreen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  void initState() {
    super.initState();
    // Delayed navigation to Home Screen after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: Colors.purple,
              image: DecorationImage(
                image: ExactAssetImage('assets/images/frame.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: size.width/2,
            left: 0,
            right: 0,
            child: Text(
              "We show weather for you",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Italic", color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: size.width/1.7,
            left: 180,
            right: 0,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text(
                "SKIP",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, fontFamily: "Italic", color: Colors.brown),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),

    );
  }
}
