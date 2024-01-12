import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/presentation/blocs/todos_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'presentation/screens/home_page.dart';
import 'di/injector.dart';
import '../todo/data/repositories/auth_repository.dart';
import '../todo/presentation/blocs/locale_bloc.dart';

void main() async {
  configureDependencies();
  await setLanguage();
  getIt.registerSingleton<AuthRepository>(SupabaseAuth());
  getIt.registerSingleton<LocaleBloc>(LocaleBloc.create());
  getIt.registerSingleton<TodosBloc>(TodosBloc());
  runApp(const TodoApp());
}

Future<void> setLanguage() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  var box = Hive.box('settings');
  if (box.get('language') == null) {
    box.put('language', 'ru');
  }
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<LocaleBloc>()),
          BlocProvider(create: (_) => getIt<TodosBloc>())
        ],
        child: BlocBuilder<LocaleBloc, Locale>(builder: (context, locale) {
          return MaterialApp(
            title: 'TodoApp',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            home: BlocBuilder<TodosBloc, TodosState>(builder: (context, state) {
              return  HomePage(state: state);
            }),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
          );
        }));
  }
}
