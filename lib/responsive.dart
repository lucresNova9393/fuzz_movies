import 'package:flutter/material.dart';
import 'package:fuzz_movies/landing.dart';
import 'package:fuzz_movies/landing1.dart';


class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if the screen is considered a "mobile" size.
        bool isMobile = constraints.maxWidth < 600;

        // Return different widgets based on screen size.
        return isMobile
            ? Landing()
            : Landing1();
      },
    );
  }
}
