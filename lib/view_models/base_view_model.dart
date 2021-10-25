import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:notification_app/core/data/models/failures.dart';
import 'package:notification_app/core/dependency_injection/di.dart';
import 'package:notification_app/core/domain/notifier_repository.dart';
import 'package:notification_app/ui/shared/toast.dart';
import 'package:notification_app/utils/constants.dart';

enum ViewState { busy, idle, error, noInternet, done }

class BaseViewModel extends ChangeNotifier {
  NotifierRepository notifierRepository;

  BaseViewModel({
    NotifierRepository notifierRepository,
  }) {
    this.notifierRepository = notifierRepository ?? locator();
    initialize();
  }
  ViewState appState = ViewState.idle;
  bool _disposed = false;
  void initialize() {
    //Can be overridden to run on initiailize
  }
  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  void log(Object e) {
    dev.log(e.toString());
  }

  setState({ViewState state = ViewState.idle}) {
    this.appState = state;
    if (!_disposed) notifyListeners();
  }

  String getErrorMessage(Failure failure) {
    if (failure.message != null) {
      if (failure.message.trim().isEmpty) return UnexpectedErrorString;

      return failure.message;
    }
    return UnexpectedErrorString;
  }

  handleFailure(Failure failure) {
    log('MESSAGE ${failure.runtimeType}');
    log(failure.message);
    AppToast.instance.error(getErrorMessage(failure));
  }
}
