import 'package:flutter/material.dart';

class TodoTextField extends StatefulWidget {
  const TodoTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<TodoTextField> createState() => _TodoTextFieldState();
}

class _TodoTextFieldState extends State<TodoTextField> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.controller.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear)
                )
              : null,
          hintText: 'Новая задача',
        ),
        onChanged: (text) {
          setState(() {});
        },
      ),
    );
  }
}