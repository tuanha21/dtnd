import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/component/account_screen_view.dart';
import 'package:dtnd/ui/screen/account/icon/account_icon.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final IUserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    final isLogin = userService.isLogin;
    Widget accountView;
    if (!isLogin) {
      accountView = Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ))
                        .then((value) => setState(() {}));
                    return;
                  },
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                  child: Text(S.of(context).login),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      accountView = AccountScreenView(
        userService: userService,
      );
    }
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                AccountIcon.bg,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 160,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  accountView,
                ],
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(4),
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.account_circle_outlined,
                color: AppColors.neutral_03,
                size: 72,
              ),
            ),
          )
        ],
      ),
    );
  }
}
