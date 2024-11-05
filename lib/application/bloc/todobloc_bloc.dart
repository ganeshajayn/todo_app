// ignore_for_file: invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp1/Domain/model/todomodel.dart';
import 'package:todoapp1/Domain/services/apiiservices.dart';

part 'todobloc_event.dart';
part 'todobloc_state.dart';

class TodoblocBloc extends Bloc<TodoblocEvent, TodoblocState> {
  ToDoApiHelper todoapihelper = ToDoApiHelper();
  TodoblocBloc(this.todoapihelper) : super(Initialtodostae()) {
    on<FetchInitialListEvent>(fetchInitialtodoListEvent);
    on<AddtoEvent>(addtoevent);
    on<UpdateEvent>(updatedTodoListEvent);
    on<DeleteEvent>(deletetodoEvent);
  }

  FutureOr<void> fetchInitialtodoListEvent(
      FetchInitialListEvent event, Emitter<TodoblocState> emitter) async {
    try {
      final todolist = await todoapihelper.fetchToDoList();

      emitter(Loadedtodostate(todolist));
    } catch (e) {
      emitter(Errormessagestate("fetching Data"));
    }
  }

  Future<void> addtoevent(
      AddtoEvent event, Emitter<TodoblocState> emitter) async {
    try {
      await todoapihelper.addToDoModel(toDo: event.addtodo);
      final todolist = await todoapihelper.fetchToDoList();
      emitter(Loadedtodostate(todolist));
    } catch (e) {
      emitter(Errormessagestate(e.toString()));
    }
  }

  Future<void> updatedTodoListEvent(
      UpdateEvent event, Emitter<TodoblocState> emitter) async {
    emitter(Loadngtodostate());
    try {
      await todoapihelper.updateToDoModel(updatedToDo: event.updatedtodo);
      final updatedlist = await todoapihelper.fetchToDoList();
      emitter(Loadedtodostate(updatedlist));
    } catch (e) {
      emitter(Errormessagestate(e.toString()));
    }
  }

  Future<void> deletetodoEvent(
      DeleteEvent event, Emitter<TodoblocState> emitter) async {
    try {
      await todoapihelper.deleteToDoModel(toDoId: event.todoid);
      final deletelist = await todoapihelper.fetchToDoList();

      emitter(Loadedtodostate(deletelist));
    } catch (e) {
      emitter(Errormessagestate(e.toString()));
    }
  }
}
