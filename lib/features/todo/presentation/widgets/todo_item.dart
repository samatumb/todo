import 'package:flutter/material.dart';
import '../../data/dtos/todo.dart';

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo,
      required this.editTodoTapped,
      required this.removeTodoTapped})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final Function() editTodoTapped;
  final Function() removeTodoTapped;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: IconButton(
        iconSize: 24,
        icon: const Icon(
          Icons.edit,
          color: Colors.blue,
        ),
        alignment: Alignment.centerLeft,
        onPressed: () {
          editTodoTapped();
        },
      ),
      title: Row(children: <Widget>[
        Expanded(
          child: Text(todo.name, style: _getTextStyle(todo.completed)),
        ),
        IconButton(
          iconSize: 24,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            removeTodoTapped();
          },
        ),
      ]),
    );
  }
}
