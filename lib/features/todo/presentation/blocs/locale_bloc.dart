import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

sealed class LocaleEvent {
  LocaleEvent(this.locale);
  final Locale locale;
}

final class SetLocaleEvent extends LocaleEvent {
  SetLocaleEvent(super.locale);
}

@injectable
class LocaleBloc extends Bloc<LocaleEvent, Locale> {
  LocaleBloc() : super(const Locale('en')) {
    on<LocaleEvent>((event, emitter) =>
        switch (event) { SetLocaleEvent() => _setLocale(event, emitter) });
  }

  _setLocale(SetLocaleEvent event, Emitter<Locale> emitter) {
    emitter(event.locale);
  }
}
