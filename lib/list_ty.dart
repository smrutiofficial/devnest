import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:devnest/task_list.dart' as task;
import 'package:devnest/task2/task2.dart' as task2;
import 'package:devnest/task3/task3.dart' as task3;

import 'checklist.dart';
import 'package:devnest/task3/checklist.dart';
import 'package:devnest/task2/checklist2.dart';

class ListTy extends StatefulWidget {
  final int activeContainer; // Accept activeContainer as a parameter

  const ListTy({super.key, required this.activeContainer});

  @override
  _ListTyState createState() => _ListTyState();
}

class _ListTyState extends State<ListTy> {
  int currentTaskIndex1 = 0; // Track the current task index for task list 1
  int currentTaskIndex2 = 0; // Track the current task index for task list 2
  int currentTaskIndex3 = 0; // Track the current task index for task list 3
  List<dynamic> getCurrentTasks() {
    switch (widget.activeContainer) {
      case 1:
        return task2.tasks2; // Use the tasks for container 1
      case 2:
        return task3.tasks3; // Use the tasks for container 2
      default:
        return task.tasks; // Default to task 1
    }
  }

  void handleNextTask() {
    setState(() {
      // Get the current task list dynamically
      final tasks = getCurrentTasks();

      // Move to the next task if within bounds
      if (widget.activeContainer == 1 && currentTaskIndex1 < tasks.length - 1) {
        currentTaskIndex1++;
      } else if (widget.activeContainer == 2 &&
          currentTaskIndex2 < tasks.length - 1) {
        currentTaskIndex2++;
      } else if (widget.activeContainer == 0 &&
          currentTaskIndex3 < tasks.length - 1) {
        currentTaskIndex3++;
      }
    });
  }

  Widget getChecklistWidget() {
    switch (widget.activeContainer) {
      case 1:
        return Checklist2(
          completedTaskIndex:
              currentTaskIndex1 - 1, // Track completion independently
        );
      case 2:
        return Checklist3(
          completedTaskIndex:
              currentTaskIndex2 - 1, // Track completion independently
        );
      default:
        return Checklist(
          completedTaskIndex:
              currentTaskIndex3 - 1, // Track completion independently
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = getCurrentTasks(); // Get the current task list
    final currentTask = tasks.isNotEmpty
        ? tasks[widget.activeContainer == 1
            ? currentTaskIndex1
            : widget.activeContainer == 2
                ? currentTaskIndex2
                : currentTaskIndex3]
        : null;
    if (currentTask == null) {
      return Center(child: Text("No tasks available"));
    }

    const themeimage = [
      {
        "img": "assets/images/update.png",
      },
      {
        "img": "assets/images/update3.png",
      },
      {
        "img": "assets/images/update2.png",
      }
    ];
    final selectedimgs = themeimage[widget.activeContainer];
    final selectedimg = selectedimgs["img"] as String;

    const colourTheme = [
      {
        "bg": Color(0xff222A39),
        "text": Color(0xffA8BBD6),
        "subtext": Color(0xffA8BBD6),
        "primary": Color(0xff5C61A9),
        "secondary": Color(0xff9CA3AF),
      },
      {
        "bg": Color(0xff272C48),
        "text": Color(0xffD1D4FF),
        "subtext": Color(0xffC0C6D6),
        "primary": Color(0xff686FBB),
        "secondary": Color(0xffF3F4F6),
      },
      {
        "bg": Color(0xff27333E),
        "text": Color(0xffEBFDFF),
        "subtext": Color(0xffAABAC6),
        "primary": Color(0xff5AA7A7),
        "secondary": Color(0xff8492A6),
      },
    ];
    final selectedColours = colourTheme[widget.activeContainer];
    final bgColor = selectedColours["bg"];
    final textColor = selectedColours["text"];
    // final primaryColor = selectedColours["primary"];

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
                color: bgColor,
              ),
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 25, bottom: 30),
                child: SingleChildScrollView(
                  child: getChecklistWidget(),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentTask.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 12),
                        // Text(
                        //   currentTask.description,
                        //   style: TextStyle(
                        //       color: const Color.fromARGB(255, 202, 202, 202),
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.w300),
                        // ),

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
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(width: 16),
                          TextButton(
                            style: ButtonStyle(
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 30),
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
