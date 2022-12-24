import 'package:flutter/material.dart';
import 'package:pet_cats_app/services/task_management_service.dart';

import '../model/task_model.dart';

class TodoCard extends StatelessWidget {
  final Task task;

  const TodoCard(
      {Key? key, required this.task,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await TaskManagement().changeStatus(task.status , task.id);

      },
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(15),
          // ignore: sort_child_properties_last
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.title,
                style: TextStyle(
                  //  condition? true : false
                  color: task.status
                      ? const Color.fromARGB(255, 27, 26, 26)
                      : Colors.white,
                  fontSize: 22,
                  decoration: task.status
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              Row(
                children: [
                  Icon(
                    task.status ? Icons.check : Icons.close,
                    size: 27,
                    color: task.status ? Colors.green[400] : Colors.red,
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  IconButton(
                    onPressed: () async {
                     await  TaskManagement().delete(task.id);
                    },
                    icon: const Icon(Icons.delete),
                    iconSize: 27,
                    color: Colors.purple,
                  )
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(11)),
        ),
      ),
    );
  }
}
