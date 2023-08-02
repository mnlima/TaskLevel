// import 'package:flutter/material.dart';
// import 'package:task_level/components/task.dart';

// class TaskInherited extends InheritedWidget {
//   TaskInherited({
//     Key? key,
//     required Widget child,
//   }) : super(key: key, child: child);

//   final List<Task> taskList = [
//     Task('Estudar Flutter', 'assets/images/flutter.png', 3),
//     Task('Estudar Dart', 'assets/images/dart.jpg', 4),
//     Task('Beber Água', 'assets/images/copoAgua.jpg', 4),
//     // Task('Estudar Typescript', 'assets/images/ts.jpg', 3),
//     // Task('Estudar Figma', 'assets/images/figma.jpg', 1),
//     Task('Jogar Dying Light', 'assets/images/dying.png', 1),
//   ];

//   void newTask(String name, String photo, int difficulty) {
//     taskList.add(Task(name, photo, difficulty));
//   }

//   static TaskInherited of(BuildContext context) {
//     final TaskInherited? result =
//         context.dependOnInheritedWidgetOfExactType<TaskInherited>();
//     assert(result != null, 'No TaskInherited found in context');
//     return result!;
//   }

//   @override
//   bool updateShouldNotify(TaskInherited oldWidget) {
//     return oldWidget.taskList.length != taskList.length;
//   }
// }
