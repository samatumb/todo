import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

sealed class LocaleEvent {
  LocaleEvent(this.locale);
  final Locale locale;
}

final class SetLocaleEvent extends LocaleEvent {
  SetLocaleEvent(super.locale);
}

@injectable
class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  final Locale locale;
  
  LocaleBloc({required this.locale}) : super(locale) {
    on<LocaleEvent>((event, emitter) =>
        switch (event) { SetLocaleEvent() => _setLocale(event, emitter) });
  }

  factory LocaleBloc.create() {
    var box = Hive.box('settings');
    return LocaleBloc(locale: Locale(box.get('language') ?? 'ru'));
  }

  _setLocale(SetLocaleEvent event, Emitter<Locale> emitter) {
    var box = Hive.box('settings');
    box.put('language', event.locale.languageCode);
    emitter(event.locale);
  }
}
