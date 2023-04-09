import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/i_local_storage_service.dart';

class SuccessSignUpPage extends StatelessWidget {
  const SuccessSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILocalStorageService localStorageService = LocalStorageService();
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              Center(
                child: Image.asset(
                  AppImages.illust04,
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Chúc mừng bạn đã đăng ký thành công!',
                style: headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Số tài khoản : ${localStorageService.sharedPreferences.get('infoRegistered')}',
                style: headlineSmall?.copyWith(fontWeight: FontWeight.w600,fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Vào Trang chủ để bắt đầu khám phá thế giới đầu tư trên IFIS ngay bạn nhé',
                style: headlineSmall?.copyWith(
                    fontSize: 20, color: AppColors.dark_bg,fontWeight:FontWeight.w600 ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        context.goNamed('home');
                      },
                      child: const Text("Vào trang chủ"))),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
