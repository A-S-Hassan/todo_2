import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_2/app_colors.dart';
import 'package:todo_2/firebase_functions.dart';
import 'package:todo_2/models/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane:
          ActionPane(motion: DrawerMotion(), extentRatio: 0.6, children: [
        SlidableAction(
          onPressed: (context) {
            firebaseFunctions.deleteTask(taskModel.id);
          },
          label: "Delete",
          backgroundColor: Colors.red,
          icon: Icons.delete,
          spacing: 8,
        ),
        SlidableAction(
          onPressed: (context) {},
          label: "Edit",
          backgroundColor: Colors.blue,
          icon: Icons.edit,
          spacing: 8,
        ),
      ]),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.symmetric(horizontal: 12),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 62,
              width: 4,
              decoration: BoxDecoration(
                color: taskModel.isDone ? Colors.green : AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    taskModel.title,
                    style: TextStyle(
                      color:
                          taskModel.isDone ? Colors.green : AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    taskModel.subTitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            taskModel.isDone
                ? Text(
                    "Done!",
                    style: TextStyle(color: Colors.green, fontSize: 22),
                  )
                : ElevatedButton(
                    onPressed: () {
                      taskModel.isDone = true;
                      firebaseFunctions.updateTask(taskModel);
                    },
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          taskModel.isDone ? Colors.green : AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
