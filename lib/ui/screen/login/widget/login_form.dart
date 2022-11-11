import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        FormField<String?>(
          builder: (field) {
            return TextFormField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: S.of(context).username,
                hintText: S.of(context).username,
              ),
            );
          },
        )
      ],
    ));
  }
}
