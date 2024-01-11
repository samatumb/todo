import 'package:flutter/material.dart';

class TodoTextField extends StatefulWidget {
  const TodoTextField(
      {super.key,
      required this.controller,
      required this.formKey,
      required this.hintText,
      required this.emptyFieldText});
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String hintText;
  final String emptyFieldText;

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
                  return widget.emptyFieldText;
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
                        icon: const Icon(Icons.clear))
                    : null,
                hintText: widget.hintText,
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
