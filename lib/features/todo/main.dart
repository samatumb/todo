import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/todo/presentation/blocs/todos_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'presentation/screens/home_page.dart';
import 'di/injector.dart';
import '../todo/data/repositories/auth_repository.dart';
import '../todo/presentation/blocs/locale_bloc.dart';

void main() {
  configureDependencies();
  getIt.registerSingleton<AuthRepository>(SupabaseAuth());
  getIt.registerSingleton<LocaleBloc>(LocaleBloc());
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<LocaleBloc>()),
        ],
        child: BlocBuilder<LocaleBloc, Locale>(builder: (context, locale) {
          return MaterialApp(
            title: 'TodoApp',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            home: BlocProvider(
              create: (_) => TodosBloc(),
              child: HomePage(),
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
          );
        }));
  }
}
