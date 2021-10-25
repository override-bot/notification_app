import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:notification_app/core/data/config/http_error_mixin.dart';
import 'package:notification_app/core/data/models/data_response.dart';
import 'package:notification_app/core/data/models/failures.dart';
import 'package:notification_app/utils/parser_util.dart';

abstract class HttpClient {
  ///Makes a get request
  Future<DataResponse<Map<String, dynamic>>> get(
    String endpoint,
  );

  ///Makes a post request
  Future<DataResponse<Map<String, dynamic>>> post(
    String endpoint, {
    Map<String, dynamic> body,
  });
}

class HttpClientImpl with ErrorCatchMixin implements HttpClient {
  final String baseUrl = 'https://class-notifier-app.herokuapp.com/';

  Map<String, String> get jsonHeadersWithoutToken => {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  Future<DataResponse<Map<String, dynamic>>> get(
    String endpoint,
  ) async {
    return catchASyncError<Map<String, dynamic>>(
      () async {
        final http.Response response = await http.get(
          Uri.parse('$baseUrl${endpoint.trim()}'),
          headers: jsonHeadersWithoutToken,
        );

        final data = jsonDecode(response.body);

        log("RESPONSE BODY FOR $endpoint: $data");

        final error = _checkForError(response.statusCode, data);

        return DataResponse<Map<String, dynamic>>(
          data: data as Map<String, dynamic>,
          error: error,
        );
      },
    );
  }

  Future<DataResponse<Map<String, dynamic>>> post(
    String endpoint, {
    Map<String, dynamic> body,
  }) async {
    return catchASyncError<Map<String, dynamic>>(() async {
      final http.Response response = await http.post(
        Uri.parse('$baseUrl${endpoint.trim()}'),
        body: jsonEncode(body),
        headers: jsonHeadersWithoutToken,
      );

      final data = jsonDecode(response.body);
      final error = _checkForError(response.statusCode, data);

      log("RESPONSE BODY FOR $endpoint: $data");
      log("RESPONSE ERROR ${error?.runtimeType}");

      return DataResponse<Map<String, dynamic>>(
        data: data as Map<String, dynamic>,
        error: error,
      );
    });
  }
}

Failure _checkForError(int statusCode, Map<String, dynamic> body) {
  if (statusCode >= 200 && statusCode < 400) {
    return null;
  } else if (statusCode >= 400 && statusCode < 500) {
    return AuthFailure(
        message: ParserUtil.parseJsonStringWithDefault(body, 'details'));
  } else if (statusCode >= 500) {
    return ServerFailure(
      ParserUtil.parseJsonStringWithDefault(
        body,
        'details',
        defaultValue:
            'We couldn\'t process your request at this time, please try again later.',
      ),
    );
  } else {
    return NetworkFailure(
        message:
            'Couldn\'t reach the servers at the moment, please try again.');
  }
}
