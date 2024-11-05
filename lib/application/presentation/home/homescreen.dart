import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp1/Domain/model/todomodel.dart';

import 'package:todoapp1/application/bloc/todobloc_bloc.dart';
import 'package:todoapp1/application/presentation/widget/textbuttonwidget.dart';
import 'package:todoapp1/application/presentation/widget/textfornfieldwidget.dart';
import 'package:todoapp1/application/presentation/widget/todolist.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      context.read<TodoblocBloc>().add(FetchInitialListEvent());
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Todo App",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addtoshowdialogue(context);
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: BlocConsumer<TodoblocBloc, TodoblocState>(
        listener: (context, state) {
          if (state is Errormessagestate) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("ERROR :${state.errormessage}"),
              duration: const Duration(seconds: 3),
            ));
          }
        },
        builder: (context, state) {
          if (state is Loadngtodostate) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loadedtodostate) {
            return TodoList(todolist: state.todolist);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

void addtoshowdialogue(BuildContext context) {
  TextEditingController tittleController = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Add todo",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
          content: SizedBox(
            height: 300,
            width: 400,
            child: Column(
              children: [
                Textformfielwidget(
                  titlecontroller: tittleController,
                  title: "title",
                ),
                const SizedBox(
                  height: 30,
                ),
                Textformfielwidget(
                    title: "Description",
                    titlecontroller: descriptioncontroller),
              ],
            ),
          ),
          actions: [
            Textbuttonwidget(
                onpressed: () {
                  Navigator.pop(context);
                },
                onpressedname: "Cancel"),
            Textbuttonwidget(
                onpressed: () {
                  if (tittleController.text.isNotEmpty) {
                    context.read<TodoblocBloc>().add(AddtoEvent(
                        addtodo: Todomodel(
                            title: tittleController.text,
                            description: descriptioncontroller.text,
                            iscompleted: false)));
                    context.read<TodoblocBloc>().add(FetchInitialListEvent());
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fill all the fields")));
                  }
                },
                onpressedname: "Add")
          ],
        );
      });
}
