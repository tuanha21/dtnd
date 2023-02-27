import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/screen/smartotp_register/page/authen_smsotp_pin.dart';
import 'package:dtnd/ui/screen/account/screen/smartotp_register/page/create_smartotp_pin.dart';
import 'package:dtnd/ui/screen/account/screen/smartotp_register/page/recreate_smartotp_pin.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

class SmartOTPRegister extends StatefulWidget {
  const SmartOTPRegister({super.key, required this.rebuild});
  final VoidCallback rebuild;

  @override
  State<SmartOTPRegister> createState() => _SmartOTPRegisterState();
}

class _SmartOTPRegisterState extends State<SmartOTPRegister> {
  final IUserService userService = UserService();
  final PageController _pageController = PageController();

  List<Widget>? _panels;

  @override
  void initState() {
    _panels = <Widget>[
      WillPopScope(
        child: CreateSmartotpPinPage(
          nextPage: nextPage,
        ),
        onWillPop: () => Future.sync(onWillPop),
      ),
      WillPopScope(
        child: RecreateSmartotpPinPage(
          nextPage: nextPage,
        ),
        onWillPop: () => Future.sync(onWillPop),
      ),
      WillPopScope(
        child: AuthenSmsotpPinPage(
          nextPage: () {
            userService.changeRegSmartOTP(true);
            Navigator.of(context).pop();

            Navigator.of(context).pop();
            widget.rebuild.call();
          },
        ),
        onWillPop: () => Future.sync(onWillPop),
      ),
    ];
    super.initState();
  }

  bool onWillPop() {
    if (_pageController.page?.round() == _pageController.initialPage) {
      return true;
    }
    return false;
  }

  void nextPage() => _pageController.nextPage(
      duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);

  void previousPage() {
    if (_pageController.page?.round() == _pageController.initialPage) {
      return Navigator.of(context).pop();
    }
    _pageController.previousPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    if (_panels?.isEmpty ?? true) {
      page = Center(
        child: Text(S.of(context).loading),
      );
    } else {
      page = PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => _panels![index],
      );
    }
    return Scaffold(
      appBar: const SimpleAppbar(title: "Đăng ký Smart OTP"),
      body: SafeArea(
        child: page,
      ),
    );
  }
}
