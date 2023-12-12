// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "access_to_location_denied": MessageLookupByLibrary.simpleMessage(
            "Odmówiono dostępu do lokalizacji"),
        "access_to_location_permanently_denied":
            MessageLookupByLibrary.simpleMessage(
                "Odmówiono dostępu do lokalizacji na stałe"),
        "allow_access_to_the_location_services":
            MessageLookupByLibrary.simpleMessage(
                "Zezwól na dostęp do usług lokalizacyjnych."),
        "allow_access_to_the_location_services_from_settings":
            MessageLookupByLibrary.simpleMessage(
                "Zezwól na dostęp do usług lokalizacyjnych dla tej aplikacji, korzystając z ustawień urządzenia."),
        "cant_get_current_location": MessageLookupByLibrary.simpleMessage(
            "Nie można uzyskać bieżącej lokalizacji"),
        "finding_place":
            MessageLookupByLibrary.simpleMessage("Wyszukiwanie miejsca..."),
        "location_denied_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Aby skorzystać z tej funkcji, wymagamy dostępu do Twojej lokalizacji."),
        "location_limited_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Dostęp do lokalizacji jest ograniczony. Aby pełni korzystać z tej funkcji, rozważ aktualizację ustawień lokalizacyjnych."),
        "location_permanently_denied_callback_msg":
            MessageLookupByLibrary.simpleMessage(
                "Dostęp do lokalizacji jest trwale zablokowany. Aby włączyć tę funkcję, przejdź do ustawień urządzenia i udziel zgody na lokalizację."),
        "location_restricted_callback_msg": MessageLookupByLibrary.simpleMessage(
            "Dostęp do lokalizacji jest ograniczony. Aby skorzystać z tej funkcji, upewnij się, że ustawienia lokalizacji Twojego urządzenia pozwalają na dostęp."),
        "mobile_settings": MessageLookupByLibrary.simpleMessage("Ustawienia"),
        "no_result_found":
            MessageLookupByLibrary.simpleMessage("Nie znaleziono wyników"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "please_check_your_connection":
            MessageLookupByLibrary.simpleMessage("Proszę sprawdzić połączenie"),
        "please_make_sure_you_enable_gps_and_try_again":
            MessageLookupByLibrary.simpleMessage(
                "Upewnij się, że włączyłeś GPS i spróbuj ponownie"),
        "search_place":
            MessageLookupByLibrary.simpleMessage("Wyszukaj miejsce"),
        "server_error": MessageLookupByLibrary.simpleMessage("Błąd serwera"),
        "unnamedPlace":
            MessageLookupByLibrary.simpleMessage("Miejsce bez nazwy")
      };
}
