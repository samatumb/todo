import 'package:flutter/material.dart';

class TodoTextField extends StatefulWidget {
  const TodoTextField({super.key, required this.controller, required this.formKey});
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;

  @override
  State<TodoTextField> createState() => _TodoTextFieldState();
}

class _TodoTextFieldState extends State<TodoTextField> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите текст задачи';
                }
                return null;
              },
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
           ),
        ],
      ),
    );
  }
}