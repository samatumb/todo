import 'package:flutter/material.dart';
import 'widgets/todo_app.dart';
import 'di/injector.dart';
import 'auth_repository.dart';

void main() {
  configureDependencies();
  getIt.registerSingleton<AuthRepository>(SupabaseAuth());
  runApp(const TodoApp());
}