import 'package:notification_app/core/data/models/data_response.dart';
import 'package:notification_app/core/models/message.dart';

abstract class NotifierRepository {
  ///Logs user in to the app.
  ///
  ///Returns the userId if successful.
  Future<DataResponse<String>> login({
    String phoneNumber,
    String password,
  });

  ///Registers user's records.
  ///
  ///Returns the userId if successful.
  Future<DataResponse<String>> register({
    String phoneNumber,
    String password,
    bool isAdmin,
  });

  ///Sends a message.
  ///
  ///Returns the number of recepients if successful
  Future<DataResponse<String>> sendMessage({
    String senderId,
    String message,
  });

  ///Retrieves all published messages.
  Future<DataResponse<List<Message>>> getMesages();
}
