class NoInternetException implements Exception {
  const NoInternetException();
}

class SomethingWentWrongException implements Exception {
  const SomethingWentWrongException();
}

class SessionExpiredException implements Exception {
  const SessionExpiredException();
}

class NotLoginException implements Exception {
  const NotLoginException();
}

class BotNotExistedException implements Exception {
  const BotNotExistedException();
}

class BoxNotOpenedException implements Exception {
  const BoxNotOpenedException();
}
