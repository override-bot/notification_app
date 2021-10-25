import 'package:notification_app/core/models/message.dart';
import 'package:notification_app/view_models/base_view_model.dart';

class DashboardViewModel extends BaseViewModel {
  List<Message> _messages = [];
  List<Message> get messages => _messages;

  ///Gets messages
  Future<void> getMessages() async {
    try {
      final response = await notifierRepository.getMesages();

      if (response.hasError) {
        //handle error
        handleFailure(response.error);
      } else {
        _messages = response.data;
        notifyListeners();
      }
    } catch (e) {
      log(e);
    }
  }
}
