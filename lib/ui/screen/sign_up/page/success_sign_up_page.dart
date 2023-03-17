import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessSignUpPage extends StatelessWidget {
  const SuccessSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Đăng ký thành công!',
                style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Text(
                'Đăng ký thành công! Vào Trang chủ để bắt đầu khám phá thế giới đầu tư trên DTND ngay bạn nhé !',
                style: headlineSmall?.copyWith(
                    fontSize: 16, color: AppColors.neutral_04),
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
