// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "asset": MessageLookupByLibrary.simpleMessage("Asset"),
        "bond": MessageLookupByLibrary.simpleMessage("Bond"),
        "double_back_to_close_app":
            MessageLookupByLibrary.simpleMessage("Back again to exit"),
        "fill_OTP": MessageLookupByLibrary.simpleMessage("Fill OTP"),
        "fill_account": MessageLookupByLibrary.simpleMessage("Fill account"),
        "fill_password": MessageLookupByLibrary.simpleMessage("Fill password"),
        "hello": MessageLookupByLibrary.simpleMessage("Hello"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "login_exception_invalid_account": MessageLookupByLibrary.simpleMessage(
            "This account has not been registered or Internet trading feature is no longer available"),
        "login_exception_invalid_password":
            MessageLookupByLibrary.simpleMessage("Password is incorrect"),
        "login_exception_required_OTP": MessageLookupByLibrary.simpleMessage(
            "Login with OTP code sent to your phone"),
        "login_upper": MessageLookupByLibrary.simpleMessage("LOGIN"),
        "market": MessageLookupByLibrary.simpleMessage("Market"),
        "minutes": MessageLookupByLibrary.simpleMessage(" minutes"),
        "no_internet":
            MessageLookupByLibrary.simpleMessage("No Internet connection"),
        "order": MessageLookupByLibrary.simpleMessage("Order"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "session_expired_in":
            MessageLookupByLibrary.simpleMessage("Session expired in "),
        "timeout":
            MessageLookupByLibrary.simpleMessage("No response from server")
      };
}
