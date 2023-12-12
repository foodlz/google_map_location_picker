// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "access_to_location_denied": MessageLookupByLibrary.simpleMessage(
            "Доступ к местоположению запрещен"),
        "access_to_location_permanently_denied":
            MessageLookupByLibrary.simpleMessage(
                "Доступ к местоположению запрещен навсегда"),
        "allow_access_to_the_location_services":
            MessageLookupByLibrary.simpleMessage(
                "Разрешить доступ к службам определения местоположения."),
        "allow_access_to_the_location_services_from_settings":
            MessageLookupByLibrary.simpleMessage(
                "Разрешите доступ к службам определения местоположения для этого приложения в настройках устройства."),
        "cant_get_current_location": MessageLookupByLibrary.simpleMessage(
            "Невозможно получить текущее местоположение"),
        "location_denied_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Для использования этой функции нам нужен доступ к вашему местоположению."),
        "location_limited_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Доступ к местоположению ограничен. Чтобы полностью использовать эту функцию, рассмотрите возможность обновления настроек местоположения."),
        "location_permanently_denied_callback_msg":
            MessageLookupByLibrary.simpleMessage(
                "Доступ к местоположению запрещен навсегда. Чтобы включить эту функцию, перейдите в настройки вашего устройства и предоставьте разрешение на местоположение."),
        "location_restricted_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Доступ к местоположению ограничен. Чтобы использовать эту функцию, убедитесь, что настройки местоположения вашего устройства разрешают доступ."),
        "mobile_settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "ok": MessageLookupByLibrary.simpleMessage("ОК"),
        "please_check_your_connection": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, проверьте ваше соединение"),
        "please_make_sure_you_enable_gps_and_try_again":
            MessageLookupByLibrary.simpleMessage(
                "Пожалуйста, убедитесь, что вы включили GPS и попробуйте снова"),
        "search_place": MessageLookupByLibrary.simpleMessage("Поиск места"),
        "server_error": MessageLookupByLibrary.simpleMessage("Ошибка сервера"),
        "unnamedPlace":
            MessageLookupByLibrary.simpleMessage("Место без названия")
      };
}
