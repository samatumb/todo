import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/extensions/locale_context_ext.dart';
import 'package:todo/features/todo/presentation/blocs/locale_bloc.dart';
import 'package:todo/features/todo/presentation/blocs/todos_bloc.dart';
import '../../data/dtos/todo.dart';
import '../widgets/todo_text_field.dart';
import '../widgets/todo_item.dart';
import '../../data/repositories/auth_repository.dart';
import '../../di/injector.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.state}) : super(key: ObjectKey(state));

  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TodosState state;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(context.loc.appTitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Localizations.localeOf(context).languageCode == 'en') {
                      context
                          .read<LocaleBloc>()
                          .add(SetLocaleEvent(const Locale('ru')));
                    } else {
                      context
                          .read<LocaleBloc>()
                          .add(SetLocaleEvent(const Locale('en')));
                    }
                  },
                  child: Text(
                      Localizations.localeOf(context).languageCode == 'en'
                          ? 'ru'
                          : 'en'))
            ]),
        body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TodoTextField(
                    controller: _controller,
                    formKey: _formKey,
                    hintText: context.loc.hint,
                    emptyFieldText: context.loc.emptyField,
                  ),
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (state.editingTodoIndex != null) {
                            Todo temp = state.todos[state.editingTodoIndex!];
                            temp.name = _controller.text;
                            context.read<TodosBloc>().add(TodoEdited(temp));
                            _controller.clear();
                          } else {
                            context.read<TodosBloc>().add(TodoAdded(Todo(
                                name: _controller.text, completed: false)));
                            _controller.clear();
                          }
                          _checkTestDI();
                        }
                      },
                      child: state.editingTodoIndex != null
                          ? Text(context.loc.add)
                          : Text(context.loc.add)),
                  Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        itemCount: state.todos.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return TodoItem(
                            todo: state.todos[index],
                            editTodoTapped: () {
                              _controller.text = state.todos[index].name;
                              context
                                  .read<TodosBloc>()
                                  .add(TodoReadyToEdit(state.todos[index]));
                            },
                            removeTodoTapped: () {
                              context
                                  .read<TodosBloc>()
                                  .add(TodoRemoved(state.todos[index]));
                              _controller.text = "";
                            },
                          );
                        }
                    ),
                  )
                ],
        ),
      ),
    );
  }

  Future<void> _checkTestDI() async {
    String text = await getIt<AuthRepository>().testString();
    print(text);
  }
}
