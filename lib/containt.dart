import 'dart:ui';

import 'package:flutter/material.dart';

class Containt extends StatelessWidget {
  final String currentTaskName;
  final String selectedimg;
  final Color textColor;
  final VoidCallback handleNextTask;

  const Containt({
    super.key,
    required this.currentTaskName,
    required this.selectedimg,
    required this.textColor,
    required this.handleNextTask,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            "assets/images/dribbble_narrow_lane.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        BackdropFilter(
          filter:ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            color: const Color.fromARGB(100, 21, 28, 38),
          ),
        ),

        // Task title
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentTaskName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),

              // Task illustration
              Center(
                child: Image.asset(
                  selectedimg,
                  width: 300,
                ),
              ),
            ],
          ),
        ),

        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Container(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  onPressed: handleNextTask,
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(width: 16),
                TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      textColor,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: handleNextTask,
                  child: Text(
                    "Install",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}