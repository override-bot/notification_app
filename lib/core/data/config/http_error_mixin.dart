import 'package:notification_app/core/data/models/data_response.dart';
import 'package:notification_app/core/data/models/failures.dart';

mixin ErrorCatchMixin {
  Future<DataResponse<T>> catchASyncError<T>(
      Future<DataResponse<T>> Function() callback) async {
    try {
      return await callback();
    } on Exception catch (e) {
      return DataResponse(
        error: handleException(e),
      );
    }
  }
}
