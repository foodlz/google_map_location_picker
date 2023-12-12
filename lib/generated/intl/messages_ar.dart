// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "access_to_location_denied": MessageLookupByLibrary.simpleMessage(
            "تم رفض إذن الوصل الي الموقع الجغرافي"),
        "access_to_location_permanently_denied":
            MessageLookupByLibrary.simpleMessage(
                "تم رفض إذن الوصل الي الموقع الجغرافي بشكل نهائي"),
        "allow_access_to_the_location_services":
            MessageLookupByLibrary.simpleMessage(
                "من فضلك قم بقبول إذن الوصول الي الموقع الجغرافي"),
        "allow_access_to_the_location_services_from_settings":
            MessageLookupByLibrary.simpleMessage(
                "من فضلك قم بقبول إذن الوصول الي الموقع الجغرافي من إدادات التطبيق."),
        "cant_get_current_location": MessageLookupByLibrary.simpleMessage(
            "لا يمكن الحصول علي الموقع الجغرافي الحالي"),
        "finding_place": MessageLookupByLibrary.simpleMessage("جاري البحث..."),
        "location_denied_callback_msg": MessageLookupByLibrary.simpleMessage(
            "لاستخدام هذه الميزة، نحن بحاجة إلى الوصول إلى موقعك."),
        "location_limited_callback_msg": MessageLookupByLibrary.simpleMessage(
            "تم تحديد وصول الموقع. لاستخدام هذه الميزة بشكل كامل، يُفضل تحديث إعدادات الموقع."),
        "location_permanently_denied_callback_msg":
            MessageLookupByLibrary.simpleMessage(
                "تم رفض وصول الموقع بشكل دائم. لتمكين هذه الميزة، انتقل إلى إعدادات جهازك وامنح إذن الوصول إلى الموقع."),
        "location_restricted_callback_msg": MessageLookupByLibrary.simpleMessage(
            "تم تقييد وصول الموقع. لاستخدام هذه الميزة، تأكد من إعدادات الموقع على جهازك للسماح بالوصول."),
        "mobile_settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "no_result_found":
            MessageLookupByLibrary.simpleMessage("لم يتم العثور على نتائج"),
        "ok": MessageLookupByLibrary.simpleMessage("حسنا"),
        "please_check_your_connection":
            MessageLookupByLibrary.simpleMessage("تأكد من وجود انترنت"),
        "please_make_sure_you_enable_gps_and_try_again":
            MessageLookupByLibrary.simpleMessage(
                "الرجاء التاكد من تفعيل الـGPS و المحاولة مرة أخري"),
        "search_place":
            MessageLookupByLibrary.simpleMessage("إبحث بإسم المكان"),
        "server_error":
            MessageLookupByLibrary.simpleMessage("خطأ من الخادم حاول مرة اخري"),
        "unnamedPlace": MessageLookupByLibrary.simpleMessage("مكان بدون اسم")
      };
}
