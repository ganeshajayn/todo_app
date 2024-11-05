import 'package:flutter/material.dart';
import 'package:todoapp1/Domain/services/apiiservices.dart';
import 'package:todoapp1/application/bloc/todobloc_bloc.dart';
import 'package:todoapp1/application/presentation/home/homescreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoblocBloc(ToDoApiHelper()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homescreen(),
      ),
    );
  }
}
