import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = HomeController();
  late final Stream<double> stream;
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInCubic);
    super.initState();
    stream = homeController.initProcess;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        homeController.init();
      },
    );
  }

  void go(BuildContext savedContext) {
    const Duration(milliseconds: 500).delay(
      () {
        if (mounted) {
          savedContext.goNamed("home");
        }
      },
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.loading_light_bg),
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: size.height / 2.7,
              child: SizedBox(
                height: 150,
                child: Image.asset(
                  AppImages.loading_light_logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Positioned(
            //     bottom: size.height * 0.1,
            //     child: SizedBox(
            //         width: 260,
            //         child: Image.asset(
            //           AppImages.loading_icon,
            //           fit: BoxFit.fitWidth,
            //         ))),
            Positioned(
              bottom: size.height * 0.4,
              child: Container(
                width: size.width / 2,
                height: 8,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppColors.neutral_05,
                ),
                child: StreamBuilder<double>(
                  initialData: 0,
                  stream: stream,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data! >= 1) {
                        go(context);
                      }

                      return Row(
                        children: [
                          AnimatedContainer(
                            width: snapshot.data! * (size.width / 2),
                            height: 8,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: AppColors.text_blue,
                            ),
                            duration: const Duration(milliseconds: 200),
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        width: 1,
                        height: 8,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: AppColors.text_blue,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.07,
              child: SizedBox(
                height: 16,
                child: Image.asset(
                  AppImages.loading_copyright,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
