import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ekyc_logic.dart';
import '../ekyc_state.dart';

class IdentityInform extends StatefulWidget {
  const IdentityInform({Key? key}) : super(key: key);

  @override
  State<IdentityInform> createState() => _IdentityInformState();
}

class _IdentityInformState extends State<IdentityInform> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isContinue = ValueNotifier<bool>(false);
  final logic = Get.find<EkycLogic>();

  EkycState get state => logic.state;

  @override
  Widget build(BuildContext context) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            logic.backStep();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Xác minh tài khoản ',
                style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Xác nhận lại thông tin đã trích xuất từ CCCD',
                style: titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.neutral_03,
                    fontSize: 14),
              ),
              const SizedBox(height: 36),
              const Text(
                'Thông tin cá nhân',
                style: TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bg_2,
                    fontSize: 16),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0),
                        labelText: "Tên giấy tờ",
                        hintText: "CCCD",
                      ),
                      // controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      onSaved: (value) {
                        // _name = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0),
                        labelText: "Họ và tên",
                        hintText: "Nguyen Van A",
                      ),
                      // controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      onSaved: (value) {
                        // _name = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0),
                        labelText: "Số giấy tờ",
                        hintText: "187594565",
                      ),
                      // controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      onSaved: (value) {
                        // _name = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0),
                        labelText: "Số giấy tờ",
                        hintText: "187594565",
                      ),
                      // controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      onSaved: (value) {
                        // _name = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0),
                        labelText: "Địa chỉ",
                        hintText: "23 Duy tân",
                      ),
                      // controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      onSaved: (value) {
                        // _name = value;
                      },
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    const Text(
                      'Thông tin nơi cấp',
                      style: TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bg_2,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        labelText: "Nơi cấp",
                        hintText: "23 Duy tân",
                      ),
                      // controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      onSaved: (value) {
                        // _name = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        labelText: "Ngày cấp",
                        hintText: "23 Duy tân",
                      ),
                      // controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      onSaved: (value) {
                        // _name = value;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0),
                        labelText: "Ngày hết hạn",
                        hintText: "23 Duy tân",
                      ),
                      // controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      onSaved: (value) {
                        // _name = value;
                      },
                    ),
                    const SizedBox(height: 36),
                    ValueListenableBuilder<bool>(
                      valueListenable: isContinue,
                      builder: (BuildContext context, isContinue, Widget? child) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: isContinue
                                ? () {

                              logic.nextStep();
                            }
                                : null,
                            child: Text(S.of(context).next),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
