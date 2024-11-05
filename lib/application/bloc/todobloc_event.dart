part of 'todobloc_bloc.dart';

@immutable
sealed class TodoblocEvent {}

class FetchInitialListEvent extends TodoblocEvent {}

class AddtoEvent extends TodoblocEvent {
  final Todomodel addtodo;
  AddtoEvent({required this.addtodo});
}

class UpdateEvent extends TodoblocEvent {
  final Todomodel updatedtodo;
  UpdateEvent({required this.updatedtodo});
}

class DeleteEvent extends TodoblocEvent {
  final String todoid;
  DeleteEvent({required this.todoid});
}
