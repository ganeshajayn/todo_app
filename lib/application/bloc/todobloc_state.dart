part of 'todobloc_bloc.dart';

@immutable
sealed class TodoblocState {}

final class Initialtodostae extends TodoblocState {}

final class Loadngtodostate extends TodoblocState {}

class Loadedtodostate extends TodoblocState {
  final List<Todomodel> todolist;
  Loadedtodostate(this.todolist);
}

class Errormessagestate extends TodoblocState {
  final String errormessage;
  Errormessagestate(this.errormessage);
}
