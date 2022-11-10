import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/logic/app_service_provider.dart';
import 'package:dtnd/ui/widget/login_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) => Text(S.of(context).hello),
              ),
              TextButton(
                onPressed: () async {
                  await ref
                      .read(appServiceProvider.notifier)
                      .state
                      .switchTheme();
                },
                child: const Text("Change Theme"),
              ),
              TextButton(
                onPressed: () {
                  ref.read(appLocaleProvider.notifier).switchLanguage();
                },
                child: const Text("Change Language"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
