// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_cats_app/widgets/counter.dart';
import 'package:pet_cats_app/widgets/todo-card.dart';

class TodoS extends StatefulWidget {
  const TodoS({Key? key}) : super(key: key);

  @override
  State<TodoS> createState() => _TodoS();
}

// class for task(todo-card)
class Task {
  String title;
  bool status;
  Task({
    required this.title,
    required this.status,
  });
}

class _TodoS extends State<TodoS> {
  // list of todos
  List allTasks = [
    Task(title: "eat the food", status: true),
    Task(title: "palying ", status: true),
    Task(title: "Training", status: true),
    Task(title: "take the vaccine", status: true),
  ];

// To remove todo  when clicking on "delete" icon
  delete(int clickedTask) {
    setState(() {
      allTasks.remove(allTasks[clickedTask]);
    });
  }

// To remove all todos  when clicking on "delete" icon in the appBar
  deleteAll() {
    setState(() {
      allTasks.removeRange(0, allTasks.length);
    });
  }

// To change the state of the todo (completed or not completed) when click on the todo
  changeStatus(int taskIndex) {
    setState(() {
      allTasks[taskIndex].status = !allTasks[taskIndex].status;
    });
  }

// To add new todo when clicking on "ADD" in the dialog widget
  addnewtask() {
    setState(() {
      allTasks.add(
        Task(title: myController.text, status: false),
      );
    });
  }

// Create controller to  get the text inside the textfield  in the dialog widget
  final myController = TextEditingController();

// To calculate only completed todos
// we will explain the difference between forEach & for loop in the next lesson (lesson11)
  int calculateCompletedTasks() {
    int completedTasks = 0;

    for (var item in allTasks) {
      if (item.status) {
        completedTasks++;
      }
    }

    return completedTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11)),
                child: Container(
                  padding: EdgeInsets.all(22),
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                          controller: myController,
                          maxLength: 20,
                          decoration:
                              InputDecoration(hintText: "Add new Task")),
                      SizedBox(
                        height: 22,
                      ),
                      TextButton(
                          onPressed: () {
                            addnewtask();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(fontSize: 22),
                          ))
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              deleteAll();
            },
            icon: Icon(Icons.delete_forever),
            iconSize: 37,
            color: Colors.purple[100],
          )
        ],
        elevation: 0,
        backgroundColor: Colors.purple,
        title: Text(
          "Task solution",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Counter(
                  allTodos: allTasks.length,
                  allCompleted: calculateCompletedTasks()),
              Container(
                margin: EdgeInsets.only(top: 22),
                height: 550,
                color: Colors.white,
                child: ListView.builder(
                    itemCount: allTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Todecard(
                          // I will pass all these information when create the Todecard() widget in "todo-card.dart" file
                          vartitle: allTasks[index].title,
                          doneORnot: allTasks[index].status,
                          changeStatus: changeStatus,
                          index: index,
                          delete: delete);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
