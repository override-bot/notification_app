import 'package:notification_app/core/data/config/http_client.dart';
import 'package:notification_app/core/data/models/data_response.dart';
import 'package:notification_app/core/domain/notifier_repository.dart';
import 'package:notification_app/core/models/message.dart';
import 'package:notification_app/utils/parser_util.dart';

class NotifierRepositoryImpl implements NotifierRepository {
  final HttpClient _client;

  NotifierRepositoryImpl(this._client);

  @override
  Future<DataResponse<List<Message>>> getMesages() async {
    final res = await _client.get("message/all");

    return res.transform(
      (data) => ParserUtil<Message>().parseJsonList(
        data['data'],
        (json) => Message.fromJson(json),
      ),
    );
  }

  @override
  Future<DataResponse<String>> login({
    String phoneNumber,
    String password,
  }) async {
    final res = await _client.post(
      "signin",
      body: {
        "phone": phoneNumber,
        "password": password,
      },
    );

    return res.transform((data) => data['user_id']);
  }

  @override
  Future<DataResponse<String>> register({
    String phoneNumber,
    String password,
    bool isAdmin,
  }) async {
    final res = await _client.post(
      "signup",
      body: {
        "phone": phoneNumber,
        "password": password,
        "admin": isAdmin ? 1 : 0
      },
    );

    return res.transform((data) => data['user_id']);
  }

  @override
  Future<DataResponse<int>> sendMessage({
    String senderId,
    String message,
  }) async {
    final res = await _client.post(
      "message/send",
      body: {
        "sender": senderId,
        "content": message,
      },
    );

    return res.transform((data) => data['recipients']);
  }
}
