// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "access_to_location_denied":
            MessageLookupByLibrary.simpleMessage("访问位置被拒绝"),
        "access_to_location_permanently_denied":
            MessageLookupByLibrary.simpleMessage("永久拒绝访问位置"),
        "allow_access_to_the_location_services":
            MessageLookupByLibrary.simpleMessage("允许访问位置服务"),
        "allow_access_to_the_location_services_from_settings":
            MessageLookupByLibrary.simpleMessage("允许使用设备设置访问此应用的位置服务"),
        "cant_get_current_location":
            MessageLookupByLibrary.simpleMessage("无法获取当前位置"),
        "finding_place": MessageLookupByLibrary.simpleMessage("找地方..."),
        "no_result_found": MessageLookupByLibrary.simpleMessage("未找到结果"),
        "ok": MessageLookupByLibrary.simpleMessage("好的"),
        "please_check_your_connection":
            MessageLookupByLibrary.simpleMessage("请检查您的连接"),
        "please_make_sure_you_enable_gps_and_try_again":
            MessageLookupByLibrary.simpleMessage("请确保您启用 GPS 并重试"),
        "search_place": MessageLookupByLibrary.simpleMessage("搜索地点"),
        "server_error": MessageLookupByLibrary.simpleMessage("服务器错误"),
        "unnamedPlace": MessageLookupByLibrary.simpleMessage("未命名的地方")
      };
}
