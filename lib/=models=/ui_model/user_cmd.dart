abstract class UserCmd {
  const UserCmd([this.data]);
  final dynamic data;
}

class BackCmd extends UserCmd {
  const BackCmd([super.data]);
}

class NextCmd extends UserCmd {
  const NextCmd([super.data]);
}
