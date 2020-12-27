import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_statemanagment/DataBase/DataBaseHelper.dart';
import 'package:todo_statemanagment/model/Task.dart';
import 'package:todo_statemanagment/provider/my_provider.dart';

import 'HomePage.dart';

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  @override
  Widget build(BuildContext context) {
    var db = DBHelper();
    db.getTaskType(0).then((value) {
      Provider.of<MyProvider>(context, listen: false).setTasks(value);
    });
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<MyProvider>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.tasks.length,
              itemBuilder: (_, int position) {
                bool isComplete = false;
                if (value.tasks[position].isComplete) {
                  isComplete = true;
                } else {
                  isComplete = false;
                }
                return Container(
                  height: 70,
                  child: Center(
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          Widget cancelButton = FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          Widget continueButton = FlatButton(
                            child: Text("Yes"),
                            onPressed: () {
                              db.deleteTask(value.tasks[position].id);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (Route<dynamic> route) => false);
                            },
                          );

                          AlertDialog alert = AlertDialog(
                            title: Text("Delete Task?"),
                            content: Text("Are you want to delete this Task?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(value.tasks[position].taskName),
                      trailing: Checkbox(
                          value: isComplete,
                          onChanged: (value1) {
                            db.updateTask(Task(
                              id: value.tasks[position].id,
                              taskName: value.tasks[position].taskName,
                              isComplete: value1,
                            ));
                            db.getTaskType(0).then((value) {
                              Provider.of<MyProvider>(context, listen: false)
                                  .setTasks(value);
                            });
                          }),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
