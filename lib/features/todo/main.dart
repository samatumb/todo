import 'package:flutter/material.dart';
import '../todo/presentation/screens/todo_app.dart';
import 'di/injector.dart';
import '../todo/data/repositories/auth_repository.dart';

void main() {
  configureDependencies();
  getIt.registerSingleton<AuthRepository>(SupabaseAuth());
  runApp(const TodoApp());
}