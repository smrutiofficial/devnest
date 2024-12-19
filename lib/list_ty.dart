import 'dart:ui';
import 'package:flutter/material.dart';
import 'checklist.dart';
import 'task_list.dart';

class ListTy extends StatefulWidget {
  const ListTy({super.key});

  @override
  _ListTyState createState() => _ListTyState();
}

class _ListTyState extends State<ListTy> {
  int currentTaskIndex = 0; // Track the current task index

  void handleNextTask() {
    setState(() {
      // Move to the next task
      if (currentTaskIndex < tasks.length - 1) {
        currentTaskIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTask = tasks[currentTaskIndex];

    return Expanded(
      child: Row(
        children: [
          // Checklist panel
          Flexible(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                color: const Color.fromARGB(255, 34, 42, 57),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25, bottom: 30),
                child: SingleChildScrollView(
                  child: Checklist(
                    completedTaskIndex: currentTaskIndex - 1, // Pass the last completed task
                  ),
                ),
              ),
            ),
          ),

          // Task display panel
          Flexible(
            flex: 13,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Stack(
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
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      color: const Color.fromARGB(100, 21, 28, 38),
                    ),
                  ),

                  // Task title
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 40),
                    child: Text(
                      currentTask.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ),

                  // Task illustration
                  Center(
                    child: Image.asset(
                      "assets/images/update.png",
                      width: 300,
                    ),
                  ),

                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
                              ),
                              shape: MaterialStateProperty.all(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(width: 16),
                          TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 255, 255, 255),
                              ),
                              shape: MaterialStateProperty.all(
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
