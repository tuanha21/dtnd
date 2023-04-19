import 'package:dtnd/ui/screen/forgot_password/%20widget/otp_widget.dart';
import 'package:dtnd/ui/screen/forgot_password/screen/change_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../generated/l10n.dart';
import '../../../../utilities/logger.dart';
import '../../../../utilities/responsive.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_snack_bar.dart';
import '../../otp/count_down.dart';
import '../../otp/otp_logic.dart';
import '../../otp/otp_state.dart';

class OtpForgotPassword extends StatefulWidget {
  final String email;

  const OtpForgotPassword({super.key, required this.email});

  @override
  State<OtpForgotPassword> createState() => _OtpForgotPasswordState();
}

class _OtpForgotPasswordState extends State<OtpForgotPassword> {
  late OtpLogic logic;

  OtpState get state => logic.state;

  @override
  void initState() {
    logic = Get.put(OtpLogic(widget.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // child: Column(
        //   children: [
        //     Text(
        //       "Nhập mã OTP",
        //       style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        //     ),
        //     const SizedBox(height: 16),
        //     RichText(
        //       text: TextSpan(children: [
        //         TextSpan(
        //             text: 'Mã OTP đã được gửi về email ',
        //             style: titleSmall?.copyWith(
        //                 fontWeight: FontWeight.w500,
        //                 color: AppColors.neutral_04)),
        //         TextSpan(
        //             text: widget.email.replaceRange(0, 3, "*"),
        //             style: titleSmall?.copyWith(
        //                 fontWeight: FontWeight.w700,
        //                 color: AppColors.primary_01)),
        //         TextSpan(
        //             text: ' của bạn. Nhập mã 6 số để tiếp tục.',
        //             style: titleSmall?.copyWith(
        //                 fontWeight: FontWeight.w500,
        //                 color: AppColors.neutral_04)),
        //       ]),
        //     ),
        //     const SizedBox(height: 32),
        //     Pinput(
        //       controller: state.pinPutController,
        //       length: 6,
        //       defaultPinTheme: defaultPinTheme,
        //       focusedPinTheme: defaultPinTheme,
        //       cursor: cursor,
        //       preFilledWidget: preFilledWidget,
        //       pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        //       onCompleted: (pin) => setState(() {}),
        //     ),
        //     const SizedBox(height: 16),
        //     TimeCountDown(
        //       textStyle: titleSmall!.copyWith(
        //         fontWeight: FontWeight.w500,
        //         color: AppColors.neutral_04,
        //       ),
        //       duration: const Duration(seconds: 30),
        //       voidCallback: () {},
        //     ),
        //     const Spacer(),
        //     SizedBox(
        //       width: Responsive.getMaxWidth(context) - 32,
        //       child: TextButton(
        //         onPressed: () async {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const ChangePassword(),
        //             ),
        //           );
        //           // try {
        //           //   //await logic.validateOTp();
        //           //   context.pushNamed('newPass');
        //           // } on FirebaseAuthException catch (e) {
        //           //   if (e.code == "invalid-verification-code") {
        //           //     AppSnackBar.showError(context,
        //           //         message: "Nhập mã OTP không chính xác");
        //           //   } else {
        //           //     AppSnackBar.showError(context, message: e.message ?? "");
        //           //   }
        //           // } catch (e) {
        //           //   logger.e(e.toString());
        //           // }
        //         },
        //         style: const ButtonStyle(
        //             padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
        //         child: Text(S.of(context).confirm),
        //       ),
        //     ),
        //     const SizedBox(height: 50)
        //   ],
        // ),
        child: OtpWidget(
          // changePassword: () {},
          email: widget.email,
          onSuccess: () {},
          resendOTP: () {},
          verifyOTP: (String A) async {
            return false;
          },
        ),
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 49,
    height: 49,
    textStyle: const TextStyle(
        fontSize: 18,
        color: AppColors.text_black_1,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.neutral_04),
      borderRadius: BorderRadius.circular(12),
      color: AppColors.neutral_06,
    ),
  );

  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 24,
        height: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.neutral_01,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 24,
        height: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primary_01,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  @override
  void dispose() {
    Get.delete<OtpLogic>();
    super.dispose();
  }
}
