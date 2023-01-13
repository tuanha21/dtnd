import 'package:flutter/cupertino.dart';

class SignUpState {

  final fullName = TextEditingController();
  final account = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();

  final keyName = GlobalKey<FormState>();
  final keyEmail = GlobalKey<FormState>();


  SignUpState() {
    ///Initialize variables
  }
}
