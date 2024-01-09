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
  HomePage({super.key});
  
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext widgetContext) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(widgetContext).colorScheme.inversePrimary,
          title: Text(widgetContext.loc.appTitle),
          actions: [
            TextButton(
              onPressed: () {
                if (Localizations.localeOf(widgetContext).languageCode == 'en') {
                  widgetContext.read<LocaleBloc>().add(SetLocaleEvent(Locale('ru')));
                } else {
                  widgetContext.read<LocaleBloc>().add(SetLocaleEvent(Locale('en')));
                }
                
              },
              child: Text(Localizations.localeOf(widgetContext).languageCode == 'en' ? 'ru' : 'en')
            )
          ]
        ),
        body: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TodoTextField(
                controller: _controller,
                formKey: _formKey,
                hintText: widgetContext.loc.hint,
                emptyFieldText: widgetContext.loc.emptyField,
              ),
              ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (state.editingTodoIndex != null) {
                    Todo temp = state.todos[state.editingTodoIndex!];
                    temp.name = _controller.text;
                    context.read<TodosBloc>().add(TodoEdited(temp));
                    _controller.clear();
                  } else {
                    context.read<TodosBloc>().add(TodoAdded(Todo(name: _controller.text, completed: false)));
                    _controller.clear();
                  }
                  _checkTestDI();
                }
              }, 
              child: state.editingTodoIndex != null ? Text(widgetContext.loc.add) : Text(widgetContext.loc.add)
            ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: state.todos.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return TodoItem(
                      todo: state.todos[index],
                      editTodoTapped: () {
                        _controller.text = state.todos[index].name;
                        context.read<TodosBloc>().add(TodoReadyToEdit(state.todos[index]));
                      },
                      removeTodoTapped: () {
                        context.read<TodosBloc>().add(TodoRemoved(state.todos[index]));
                        _controller.text = "";
                      },
                    );
                  }
                ),  
              )
            ],
          )
        ),
      ),
    );
  }

  Future<void> _checkTestDI() async {
    String text = await getIt<AuthRepository>().testString();
    print(text);
  }
}
