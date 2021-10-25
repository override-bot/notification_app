import 'dart:developer';
import 'package:notification_app/utils/constants.dart';

class ParserUtil<T> {
  static final roundedNumberRegex = RegExp(r"([.]*0+)(?!.*\d)");

  static String parseNumToString(dynamic doubleString) {
    try {
      final number = num.parse("$doubleString");
      return number.toString().replaceAll(roundedNumberRegex, "");
    } catch (e) {
      return "";
    }
  }

  static String parseNumToStringWithoutRounding(dynamic doubleString) {
    try {
      final number = num.parse("$doubleString");
      return number.toString();
    } catch (e) {
      return "";
    }
  }

  static Object parseJson(Map json, String param, {Object type = String}) {
    try {
      if (type == DateTime) {
        return DateTime.parse(json[param]);
      }
      if (type == double) {
        final number = double.parse("${json[param]}");
        return double.parse(
          number.toString().replaceAll(roundedNumberRegex, ""),
        );
      }
      if (type == int) {
        return int.parse("${json[param]}");
      }
      if (type == String) {
        return "${json[param]}";
      }
      return json[param];
    } catch (e) {
      log(e.toString());
      switch (type) {
        case bool:
          return false;
        case DateTime:
          return DateTime.now();
        case int:
        case double:
          return 0;
        default:
          return "";
      }
    }
  }

  static String formatCurrency(String number, {String currencyPrefix = 'N'}) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

    final mathFunc = (Match match) => '${match[1]},';

    String result = number.replaceAllMapped(reg, mathFunc);
    return "$currencyPrefix$result";
  }

  static DateTime parseJsonDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String parseJsonString(Map json, String param) {
    try {
      return json[param];
    } catch (e) {
      return '';
    }
  }

  static bool parseJsonBoolean(Map json, String param) {
    try {
      return json[param];
    } catch (e) {
      return false;
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

  static int getJsonListCount(List<dynamic> json) {
    try {
      return json.length;
    } catch (e) {
      return 0;
    }
  }

  static String _appendDateSuffix(int day) {
    switch (day) {
      case 1:
      case 21:
      case 31:
        return '${day}st';
      case 2:
      case 22:
        return '${day}nd';
      case 3:
      case 23:
        return '${day}rd';

      default:
        return '${day}th';
    }
  }

  static String _getDay(int day) {
    switch (day) {
      case 1:
        return 'Mon.';
      case 2:
        return 'Tue.';
      case 3:
        return 'Wed.';
      case 4:
        return 'Thur.';
      case 5:
        return 'Fri.';
      case 6:
        return 'Sat.';

      default:
        return 'Sun.';
    }
  }

  static String _getMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      default:
        return "December";
    }
  }

  static String stringifyDateForCreditManagement(DateTime date) {
    return "${_appendDateSuffix(date.day)} ${_getMonth(date.month).substring(0, 3)} ${date.year}";
  }

  static String stringifyDate(DateTime date, [bool withYear = true]) {
    String result = "${_appendDateSuffix(date.day)} ${_getMonth(date.month)}";

    if (withYear) return result + ", ${date.year}";
    return result;
  }

  static String stringigyDateForLoanApplication(DateTime date) {
    return "${_getDay(date.weekday)} ${_appendDateSuffix(date.day)} ${_getMonth(date.month)}, ${date.year}";
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
