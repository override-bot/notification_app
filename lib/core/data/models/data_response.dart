import 'package:notification_app/core/data/models/failures.dart';

class DataResponse<T> {
  final Failure error;
  final T data;
  DataResponse({this.data, this.error})
      : assert((data != null) || (error != null),
            'Both data and error cannot be null]');

  bool get hasError => error != null;
}

extension Converter<E> on DataResponse<Map<String, dynamic>> {
  DataResponse<E> transform<E>(
    E Function(Map<String, dynamic> data) transformer, {
    bool ignoreError = false,
  }) {
    E transformedData;
    if (data != null) {
      transformedData = (ignoreError || !hasError) ? transformer(data) : null;
    }
    return DataResponse<E>(
      data: transformedData,
      error: error,
    );
  }
}
