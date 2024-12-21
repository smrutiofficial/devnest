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
  final ValueChanged<String> onProcessStatusChange;

  const ListTy({
    super.key,
    required this.activeContainer,
    required this.onProcessStatusChange,
  });

  @override
  _ListTyState createState() => _ListTyState();
}

class _ListTyState extends State<ListTy> {
  int currentTaskIndex1 = 0;
  int currentTaskIndex2 = 0;
  int currentTaskIndex3 = 0;

  bool isFirstComplte = false;
  bool isSecComplte = false;
  bool isTrairdComplte = false;

  String processStatus = "none";

  void updateProcessStatus(String status) {
    setState(() {
      processStatus = status;
    });
    widget.onProcessStatusChange(status); // Notify parent of status change
  }

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

  // =============================================

  void handleNextTask() async {
    // Get the current task list dynamically
    final tasks = getCurrentTasks();

    // Ensure there is a current task to execute
    if (tasks.isEmpty) return;

    // Determine the current task based on the active container and task index
    // final currentTask = (widget.activeContainer == 1)
    //     ? tasks[currentTaskIndex1]
    //     : (widget.activeContainer == 2)
    //         ? tasks[currentTaskIndex2]
    //         : tasks[currentTaskIndex3];

    try {
      // setState(() {
        updateProcessStatus("processing");
        // processStatus = "processing";
      // });
      // Open GNOME terminal and wait for the command to finish
      final result = await Process.run('gnome-terminal', [
        '--wait', // Wait for the command to finish
        '--',
        'bash',
        '-c',
        'echo updateed ; sleep 1; exit 0',
      ]);

      // Check if the process completed successfully
      if (result.exitCode == 0) {
        // setState(() {
          // processStatus = "finish";
          updateProcessStatus("finish");
        // });
        // Execute setState only after the terminal command completes
        setState(() {
          // print(widget.activeContainer);
          if (widget.activeContainer == 0 &&
              currentTaskIndex1 < tasks.length - 1) {
            currentTaskIndex1++;
            // print("c1");
          } else if (widget.activeContainer == 1 &&
              currentTaskIndex2 < tasks.length - 1) {
            currentTaskIndex2++;
            // print("c2");
          } else if (widget.activeContainer == 2 &&
              currentTaskIndex3 < tasks.length - 1) {
            currentTaskIndex3++;
            // print("c3");
          } else {
            updateProcessStatus("finish");
            // processStatus = "finish";
            // Ensure the last task is marked as completed
            if (widget.activeContainer == 1) {
              currentTaskIndex2 = tasks.length - 1;
              isSecComplte = true;
              // print(isFirstComplte);
            } else if (widget.activeContainer == 2) {
              currentTaskIndex3 = tasks.length - 1;
              isTrairdComplte = true;
              // print(isSecComplte);
            } else {
              currentTaskIndex1 = tasks.length - 1;
              isFirstComplte = true;
              // print(isTrairdComplte);
            }
          }
        });
        // print(isFirstComplte);
        // print(isTrairdComplte);
        // print(isTrairdComplte);
      } else {
        setState(() {
          processStatus = "cerror";
        });
      }
    } catch (e) {
      // Handle exceptions gracefully
      setState(() {
        processStatus = "error";
      });
    }
  }

  // =============================================

  Widget getChecklistWidget() {
    switch (widget.activeContainer) {
      case 1:
        return Checklist2(
          completedTaskIndex: currentTaskIndex2 - 1,
          processStatus: processStatus,
          isSecComplte: isSecComplte,
        );
      case 2:
        return Checklist3(
          completedTaskIndex: currentTaskIndex3 - 1,
          processStatus: processStatus,
          isTrairdComplte: isTrairdComplte,
        );
      default:
        return Checklist(
          completedTaskIndex: currentTaskIndex1 - 1,
          processStatus: processStatus,
          isFirstComplte: isFirstComplte,
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
                  processStatus: processStatus,
                  activeContainer: widget.activeContainer,
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
