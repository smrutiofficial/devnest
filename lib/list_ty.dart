import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:devnest/task_list.dart' as task;
import 'package:devnest/task2/task2.dart' as task2;
import 'package:devnest/task3/task3.dart' as task3;

import 'checklist.dart';
import 'package:devnest/task3/checklist.dart';
import 'package:devnest/task2/checklist2.dart';
import 'package:devnest/containt.dart';

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

  void handleNextTask() async {
    // Get the current task list dynamically
    final tasks = getCurrentTasks();

    try {
    //   final result = await Process.run('bash', [
    //   '-c',
    //   'sleep 5; echo hello; exit 0' // Your Bash script here
    // ]);
     // Open GNOME terminal and wait for the command to finish
    final result = await Process.run('gnome-terminal', [
      '--wait', // Wait for the command to finish
      '--',
      'bash',
      '-c',
      'sleep 5; echo hello; exit 0' // Your Bash script here
    ]);

      // Check if the process completed successfully
      if (result.exitCode == 0) {
        // Execute setState only after the terminal command completes
        setState(() {
          if (widget.activeContainer == 1 &&
              currentTaskIndex1 < tasks.length - 1) {
            currentTaskIndex1++;
          } else if (widget.activeContainer == 2 &&
              currentTaskIndex2 < tasks.length - 1) {
            currentTaskIndex2++;
          } else if (widget.activeContainer == 0 &&
              currentTaskIndex3 < tasks.length - 1) {
            currentTaskIndex3++;
          }
        });
      } else {
        print(
            "Error: Terminal command failed with exit code ${result.exitCode}");
      }
    } catch (e) {
      // Handle errors gracefully
      print("An error occurred: $e");
    }
  }

  Widget getChecklistWidget() {
    switch (widget.activeContainer) {
      case 1:
        return Checklist2(
          completedTaskIndex: currentTaskIndex1 - 1,
        );
      case 2:
        return Checklist3(
          completedTaskIndex: currentTaskIndex2 - 1,
        );
      default:
        return Checklist(
          completedTaskIndex: currentTaskIndex3 - 1,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = getCurrentTasks();
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
    final currentTaskName = currentTask.name;
    final currentTaskdes = currentTask.description;
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
    final textColor = selectedColours["text"] ?? Colors.white;
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

              // ----------------------------------------------
              // ====================================================
              // -------------------------------------------------------------
              child: Containt(
                  currentTaskName: currentTaskName,
                  currentTaskdes: currentTaskdes,
                  selectedimg: selectedimg,
                  textColor: textColor,
                  handleNextTask: handleNextTask),
              // ----------------------------------------------
              // ====================================================
              // -------------------------------------------------------------
            ),
          ),
        ],
      ),
    );
  }
}
