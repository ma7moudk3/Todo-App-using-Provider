import 'package:flutter/material.dart';
import 'package:todo_statemanagment/model/Task.dart';

class MyProvider extends ChangeNotifier {
  List<Task> tasks;
  setTasks(tasks) {
    this.tasks = tasks;
    notifyListeners();
  }
}
