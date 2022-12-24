import 'package:flutter/material.dart';
import 'package:pet_cats_app/services/task_management_service.dart';
import 'package:pet_cats_app/shared/loading.dart';
import 'package:pet_cats_app/widgets/counter.dart';
import 'package:pet_cats_app/widgets/todo_card.dart';
import 'package:uuid/uuid.dart';

import '../model/task_model.dart';

class TodoS extends StatefulWidget {
  const TodoS({Key? key}) : super(key: key);

  @override
  State<TodoS> createState() => _TodoS();
}

class _TodoS extends State<TodoS> {
  // list of todos
  List<Task>? allTasks;

// Create controller to  get the text inside the textfield  in the dialog widget
  final taskTitleController = TextEditingController();

// To calculate only completed todos
// we will explain the difference between forEach & for loop in the next lesson (lesson11)
  int calculateCompletedTasks() {
    int completedTasks = 0;

    for (var item in allTasks!) {
      if (item.status) {
        completedTasks++;
      }
    }

    return completedTasks;
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  getTasks() async {
    allTasks = await TaskManagement().getTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getTasks();
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
                  padding: const EdgeInsets.all(22),
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                          controller: taskTitleController,
                          maxLength: 20,
                          decoration:
                              const InputDecoration(hintText: "Add new Task")),
                      const SizedBox(
                        height: 22,
                      ),
                      TextButton(
                          onPressed: () async {
                            await Loading.wrap(
                              context: context,
                              function: () async {
                                await TaskManagement().addNewTask(Task(
                                    id: const Uuid().v4(),
                                    title: taskTitleController.text,
                                    status: false));
                              },
                            );
                            taskTitleController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text(
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
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await Loading.wrap(
                context: context,
                function: () async {
                  await TaskManagement().deleteAll();
                },
              );
            },
            icon: const Icon(Icons.delete_forever),
            iconSize: 37,
            color: Colors.purple[100],
          )
        ],
        elevation: 0,
        backgroundColor: Colors.purple,
        title: const Text(
          "Task solution",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: allTasks == null
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Counter(
                        allTodos: allTasks!.length,
                        allCompleted: calculateCompletedTasks()),
                    Container(
                      margin: const EdgeInsets.only(top: 22),
                      height: 550,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: allTasks!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TodoCard(
                              // I will pass all these information when create the Todecard() widget in "todo-card.dart" file
                              task: allTasks![index],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
