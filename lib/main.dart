import 'package:flutter/material.dart';
import 'package:devnest/list_ty.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 21, 28, 38),
                const Color.fromARGB(255, 50, 68, 94)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "genome theme.",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 138, 153, 177),
                      fontSize: 22),
                ),
                SizedBox(height: 5),
                Text(
                  "Ubuntu Dev Setup",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 230, 237, 248),
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 32),
                ListTy(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
