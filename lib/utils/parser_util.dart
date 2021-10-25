import 'dart:developer';
import 'package:notification_app/utils/constants.dart';

class ParserUtil<T> {
  static String parseJsonString(Map json, String param) {
    try {
      return json[param].toString();
    } catch (e) {
      return '';
    }
  }

  List<T> parseJsonList(
    List<dynamic> json,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    try {
      final data = List<Map<String, dynamic>>.from(json);

      return List<T>.from(
        data.map(
          (e) => fromJson(e),
        ),
      );
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static String parseJsonStringWithDefault(
    Map json,
    String param, {
    String defaultValue = UnexpectedErrorString,
  }) {
    try {
      final value = json[param] as String;

      if (value.isEmpty) return defaultValue;

      return value;
    } catch (e) {
      return defaultValue;
    }
  }
}
