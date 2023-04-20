import 'package:dtnd/=models=/check_account_success_data_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/forgot_password/%20widget/otp_widget.dart';
import 'package:dtnd/ui/screen/forgot_password/screen/change_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../otp/otp_logic.dart';
import '../../otp/otp_state.dart';

class OtpForgotPassword extends StatefulWidget {
  final String email;

  final CheckAccountSuccessDataModel accountInfo;

  const OtpForgotPassword(
      {super.key, required this.email, required this.accountInfo});

  @override
  State<OtpForgotPassword> createState() => _OtpForgotPasswordState();
}

class _OtpForgotPasswordState extends State<OtpForgotPassword> {
  late OtpLogic logic;
  final IUserService userService = UserService();

  OtpState get state => logic.state;

  Future<bool> resendOtp(String mobile, String mail) {
    return userService.verifyRegisterInfo(mobile, mail);
  }

  @override
  void initState() {
    logic = Get.put(OtpLogic(widget.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: OtpWidget(
          email: widget.email,
          onSuccess: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangePassword(
                        accountInfo: widget.accountInfo,
                      )),
            );
          },
          resendOTP: () => resendOtp(
            widget.accountInfo.cCUSTMOBILE!,
            widget.accountInfo.cCUSTEMAIL!,
          ),
          verifyOTP: (otp) => userService.verifyRegisterOTP(
              widget.accountInfo.cCUSTMOBILE!,
              widget.accountInfo.cCUSTEMAIL!,
              otp),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<OtpLogic>();
    super.dispose();
  }
}
