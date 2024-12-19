import 'package:flutter/material.dart';
import 'task2.dart';

class Checklist2 extends StatelessWidget {
  final int completedTaskIndex;

  const Checklist2({super.key, required this.completedTaskIndex});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tasks2.length,
      itemBuilder: (context, index) {
        final task = tasks2[index];
        final isCompleted = index <= completedTaskIndex; // Completed up to the current index - 1

        return ListTile(
          title: Text(
            task.name,
            style: TextStyle(
              color: isCompleted
                  ? Colors.grey
                  : Color.fromARGB(255, 138, 153, 177),
              decoration: isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          leading: Checkbox(
            value: isCompleted,
            onChanged: null, // Disable manual toggling
            activeColor: const Color.fromARGB(255, 138, 153, 177),
            checkColor: Colors.white,
            side: BorderSide(
              color: isCompleted
                  ? Colors.green
                  : const Color.fromARGB(255, 138, 153, 177),
              width: 2,
            ),
          ),
        );
      },
    );
  }
}
