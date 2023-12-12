// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
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
  String get localeName => 'uk';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "access_to_location_denied": MessageLookupByLibrary.simpleMessage(
            "Відмовлено в доступі до місцезнаходження"),
        "access_to_location_permanently_denied":
            MessageLookupByLibrary.simpleMessage(
                "Відмовлено в доступі до місцезнаходження назавжди"),
        "allow_access_to_the_location_services":
            MessageLookupByLibrary.simpleMessage(
                "Дозвольте доступ до служб місцезнаходження."),
        "allow_access_to_the_location_services_from_settings":
            MessageLookupByLibrary.simpleMessage(
                "Дозвольте доступ до служб місцезнаходження для цього додатка, використовуючи налаштування пристрою."),
        "cant_get_current_location": MessageLookupByLibrary.simpleMessage(
            "Не вдається отримати поточне місцезнаходження"),
        "finding_place": MessageLookupByLibrary.simpleMessage("Пошук місця..."),
        "location_denied_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Для використання цієї функції нам потрібен доступ до вашого місцезнаходження."),
        "location_limited_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Доступ до місцезнаходження обмежений. Щоб повністю використовувати цю функцію, розгляньте можливість оновлення налаштувань місцезнаходження."),
        "location_permanently_denied_callback_msg":
            MessageLookupByLibrary.simpleMessage(
                "Доступ до місцезнаходження назавжди відмовлено. Щоб увімкнути цю функцію, перейдіть до налаштувань вашого пристрою та дайте дозвіл на місцезнаходження."),
        "location_restricted_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Доступ до місцезнаходження обмежений. Для використання цієї функції переконайтеся, що налаштування місцезнаходження вашого пристрою налаштовані на дозвіл доступу."),
        "mobile_settings": MessageLookupByLibrary.simpleMessage("Налаштування"),
        "no_result_found":
            MessageLookupByLibrary.simpleMessage("Результати не знайдено"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "please_check_your_connection": MessageLookupByLibrary.simpleMessage(
            "Будь ласка, перевірте ваше з\'єднання"),
        "please_make_sure_you_enable_gps_and_try_again":
            MessageLookupByLibrary.simpleMessage(
                "Будь ласка, переконайтеся, що ви включили GPS та спробуйте ще раз"),
        "search_place": MessageLookupByLibrary.simpleMessage("Пошук місця"),
        "server_error": MessageLookupByLibrary.simpleMessage("Помилка сервера"),
        "unnamedPlace": MessageLookupByLibrary.simpleMessage("Місце без назви")
      };
}
