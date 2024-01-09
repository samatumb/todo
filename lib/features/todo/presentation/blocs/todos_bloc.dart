import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/dtos/todo.dart';

sealed class TodoEvent {
  TodoEvent(this.todo);
  final Todo todo;
}

final class TodoAdded extends TodoEvent {
  TodoAdded(super.todo);
}

final class TodoRemoved extends TodoEvent {
  TodoRemoved(super.todo);
}

final class TodoEdited extends TodoEvent {
  TodoEdited(super.todo);
}

final class TodoReadyToEdit extends TodoEvent {
  TodoReadyToEdit(super.todo);
}

final class TodosState {
  TodosState(this.todos, this.editingTodoIndex);
  final List<Todo> todos;
  final int? editingTodoIndex;
}

class TodosBloc extends Bloc<TodoEvent, TodosState> {
  TodosBloc() : super(TodosState([], null)) {
    on<TodoAdded>((event, emit) {
      List<Todo> temp = List.from(state.todos);
      temp.add(event.todo);
      emit(TodosState(temp, null));
    });
    on<TodoRemoved>((event, emit) {
      List<Todo> temp = List.from(state.todos);
      temp.remove(event.todo);
      emit(TodosState(temp, null));
    });
    on<TodoEdited>((event, emit) {
      List<Todo> temp = List.from(state.todos);
      int index = temp.indexOf(event.todo);
      temp[index].name = event.todo.name;
      emit(TodosState(temp, null));
    });
    on<TodoReadyToEdit>((event, emit) {
      int index = state.todos.indexOf(event.todo);
      emit(TodosState(state.todos, index));
    });
  }
}