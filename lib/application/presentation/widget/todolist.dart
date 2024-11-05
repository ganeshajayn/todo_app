import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp1/Domain/model/todomodel.dart';
import 'package:todoapp1/application/bloc/todobloc_bloc.dart';
import 'package:todoapp1/application/presentation/widget/textfornfieldwidget.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todolist});
  final List<Todomodel> todolist;
  @override
  Widget build(BuildContext context) {
    return todolist.isEmpty
        ? const Center(
            child: Text(
            "No task Found",
            style: TextStyle(color: Colors.white),
          ))
        : ListView.builder(
            itemCount: todolist.length,
            itemBuilder: (context, index) {
              Todomodel todo = todolist[index];
              TextEditingController tittleedittingcontroller =
                  TextEditingController(text: todo.title);
              TextEditingController descriptioneditingcontroller =
                  TextEditingController(text: todo.description);
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 225, 214, 242)),
                  child: ListTile(
                    title: Text(
                      todo.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Edit Todo",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      content: SizedBox(
                                        height: 300,
                                        child: Column(
                                          children: [
                                            Textformfielwidget(
                                                title: "tittle",
                                                titlecontroller:
                                                    tittleedittingcontroller),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Textformfielwidget(
                                                title: "Description",
                                                titlecontroller:
                                                    descriptioneditingcontroller)
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel")),
                                        TextButton(
                                            onPressed: () {
                                              context.read<TodoblocBloc>().add(
                                                  UpdateEvent(
                                                      updatedtodo: Todomodel(
                                                          title:
                                                              tittleedittingcontroller
                                                                  .text,
                                                          description:
                                                              descriptioneditingcontroller
                                                                  .text,
                                                          iscompleted: false)));
                                              context
                                                  .read<TodoblocBloc>()
                                                  .add(FetchInitialListEvent());
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Save"))
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: const Text(
                                          "Are You Sure Want to delete this task"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel")),
                                        TextButton(
                                            onPressed: () {
                                              context.read<TodoblocBloc>().add(
                                                  DeleteEvent(
                                                      todoid: todo.id!));
                                              context
                                                  .read<TodoblocBloc>()
                                                  .add(FetchInitialListEvent());
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Delete"))
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}
