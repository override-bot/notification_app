import 'package:notification_app/ui/shared/toast.dart';
import 'package:notification_app/utils/constants.dart';
import 'package:notification_app/view_models/base_view_model.dart';
import 'dart:html' as html;

class AuthViewModel extends BaseViewModel {
  ///Saves user's contact so they can get
  ///SMS notifications
  ///
  ///Does almost the same thing as [register] except
  ///this is used by non-admins instead
  Future<void> saveContact(
    String phoneNumber,
  ) async {
    try {
      if (phoneNumber == null || phoneNumber.isEmpty) {
        AppToast.instance.error("Phone number field cannot be empty");
        return;
      }

      setState(state: ViewState.busy);

      final response = await notifierRepository.register(
        password: "defaultPassword",
        phoneNumber: phoneNumber,
        isAdmin: false,
      );

      if (response.hasError) {
        //handle error
        handleFailure(response.error);
      } else {
        //user's contact has been saved, show a response
        //to indicate success
        setState();
        AppToast.instance.showSnackBar(
            message: "Your contact has been added to the database");
      }
    } catch (e) {
      setState();
      log(e);
    }
  }

  ///Registers a new user as an admin
  Future<void> register({
    String phoneNumber,
    String password,
  }) async {
    try {
      setState(state: ViewState.busy);

      final response = await notifierRepository.register(
        password: password,
        phoneNumber: phoneNumber,
        isAdmin: true,
      );

      if (response.hasError) {
        //handle error
        handleFailure(response.error);
      } else {
        setState();

        //store user id in local storage
        //consider scoping/encrypting this as this data
        //is visible to all apps running on the browser
        html.window.localStorage[USER_ID] = response.data;

        //user regisetered, auto log in and navigate to dashboard
      }
    } catch (e) {
      setState();
      log(e);
    }
  }

  ///Logs a user in
  Future<void> login({
    String phoneNumber,
    String password,
  }) async {
    try {
      setState(state: ViewState.busy);

      final response = await notifierRepository.login(
        password: password,
        phoneNumber: phoneNumber,
      );

      if (response.hasError) {
        //handle error
        handleFailure(response.error);
      } else {
        setState();

        //store user id in local storage
        //consider scoping/encrypting this as this data
        //is visible to all apps running on the browser
        html.window.localStorage[USER_ID] = response.data;

        //user logged in, navigate to dashboard
      }
    } catch (e) {
      setState();
      log(e);
    }
  }
}
