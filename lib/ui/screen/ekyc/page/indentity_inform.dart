import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../ekyc_logic.dart';
import '../ekyc_state.dart';

class IdentityInform extends StatefulWidget {
  const IdentityInform({Key? key}) : super(key: key);

  @override
  State<IdentityInform> createState() => _IdentityInformState();
}

class _IdentityInformState extends State<IdentityInform> {
  final _formKey = GlobalKey<FormState>();
  EkycState get state => logic.state;

  ValueNotifier<bool> isContinue = ValueNotifier<bool>(true);
  final logic = Get.find<EkycLogic>();
  late TextEditingController birthDateCtl =
      TextEditingController(text: '1/1/1999');
  late TextEditingController rangeDateCtl = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  late TextEditingController expirationDateCtl = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  bool _genderMale = true;

  void chooseGender() {
    setState(() {
      _genderMale = !_genderMale;
    });
  }

  void pickBirthDate() async {
    DateTime? date = DateTime(1900);
    FocusScope.of(context).requestFocus(FocusNode());
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    birthDateCtl.text = DateFormat('dd/MM/yyyy').format(date ?? DateTime.now());
  }

  void pickRangeDate() async {
    DateTime? date = DateTime(1900);
    FocusScope.of(context).requestFocus(FocusNode());
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    rangeDateCtl.text = DateFormat('dd/MM/yyyy').format(date ?? DateTime.now());
  }

  void pickExpirationDate() async {
    DateTime? date = DateTime(1900);
    FocusScope.of(context).requestFocus(FocusNode());
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    expirationDateCtl.text =
        DateFormat('dd/MM/yyyy').format(date ?? DateTime.now());
  }

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
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0),
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
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0),
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
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0),
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
                    Stack(children: [
                      TextFormField(
                        controller: birthDateCtl,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          labelText: "Ngày sinh",
                        ),
                        onTap: pickBirthDate,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: GestureDetector(
                          onTap: pickBirthDate,
                          child: const Icon(
                            Icons.calendar_month,
                            color: AppColors.text_black,
                            size: 24.0,
                          ),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // obscureText: _passwordVisible,
                      decoration: const InputDecoration(
                        errorStyle: TextStyle(height: 0),
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
                      height: 20,
                    ),
                    Stack(children: [
                      TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          labelText: "Giới tính",
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      Positioned(
                        left: 20,
                        top: 10,
                        child: SizedBox(
                          height: 30,
                          width: 200,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: chooseGender,
                                child: Image.asset(
                                  _genderMale
                                      ? AppImages.true_checkbox
                                      : AppImages.false_checkbox,
                                  height: _genderMale ? 24 : 20,
                                  width: _genderMale ? 24 : 20,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text('Nam'),
                              const SizedBox(width: 30),
                              GestureDetector(
                                onTap: chooseGender,
                                child: Image.asset(
                                  !_genderMale
                                      ? AppImages.true_checkbox
                                      : AppImages.false_checkbox,
                                  height: !_genderMale ? 24 : 20,
                                  width: !_genderMale ? 24 : 20,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Text('Nữ'),
                            ],
                          ),
                        ),
                      )
                    ]),
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
                    Stack(children: [
                      TextFormField(
                        controller: rangeDateCtl,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          labelText: "Ngày cấp",
                        ),
                        onTap: pickRangeDate,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: GestureDetector(
                          onTap: pickRangeDate,
                          child: const Icon(
                            Icons.calendar_month,
                            color: AppColors.text_black,
                            size: 24.0,
                          ),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(children: [
                      TextFormField(
                        controller: expirationDateCtl,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          labelText: "Ngày hết hạn",
                        ),
                        onTap: pickExpirationDate,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: GestureDetector(
                          onTap: pickExpirationDate,
                          child: const Icon(
                            Icons.calendar_month,
                            color: AppColors.text_black,
                            size: 24.0,
                          ),
                        ),
                      )
                    ]),
                    const SizedBox(height: 36),
                    ValueListenableBuilder<bool>(
                      valueListenable: isContinue,
                      builder:
                          (BuildContext context, isContinue, Widget? child) {
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
                    const SizedBox(
                      height: 40,
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
