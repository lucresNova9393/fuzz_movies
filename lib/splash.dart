import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fuzz_movies/responsive.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Responsive(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height;
    final w=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          Center(
            child:  Container(
              margin: EdgeInsets.symmetric(vertical: h*.010),
              height: h*.300,
              width: w*.700,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      image: DecorationImage(

                          image: AssetImage('assets/animation/fuzz3.png'),fit: BoxFit.contain),
                    ),
                  ),
                  Positioned(
                    bottom:0,
                    left: 0,
                    right: 0,
                    child:   Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        "assets/animation/fuzz2.jpg",
                        width: w,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
