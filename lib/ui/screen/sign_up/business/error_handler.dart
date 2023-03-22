enum ErrorType { fullname, phoneNumber, email, password, none }

class ErrorHandler {
  static final Map<ErrorType, List<int>> _errorCodePartition = {
    ErrorType.phoneNumber: [
      2039,
    ],
    ErrorType.email: [
      2040,
    ]
  };

  static ErrorType getTypeFromCode(int rc) {
    for (var i = 0; i < _errorCodePartition.length; i++) {
      if (_errorCodePartition.values.toList().elementAt(i).contains(rc)) {
        return _errorCodePartition.keys.toList().elementAt(i);
      } else {
        continue;
      }
    }
    return ErrorType.none;
  }
}
