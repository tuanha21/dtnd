import 'package:dtnd/ui/screen/community/widget/create_group_widget/number_steper.dart';
import 'package:dtnd/ui/screen/community/widget/create_group_widget/step_widget/step1.dart';
import 'package:dtnd/ui/screen/community/widget/create_group_widget/step_widget/step2.dart';
import 'package:dtnd/ui/screen/community/widget/create_group_widget/step_widget/step3.dart';
import 'package:dtnd/ui/screen/community/widget/create_group_widget/step_widget/step4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'create_group_controller.dart';

class CreateGroupWidget extends StatefulWidget {
  const CreateGroupWidget({Key? key}) : super(key: key);

  @override
  State<CreateGroupWidget> createState() => _CreateGroupWidgetState();
}

class _CreateGroupWidgetState extends State<CreateGroupWidget> {
  final Duration stepProcessDuration = const Duration(milliseconds: 100);
  final CreateGroupController controller = CreateGroupController();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page?.round() ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông tin nhóm",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: _currentPage > 0
              ? const Icon(Icons.arrow_back)
              : const Icon(Icons.close),
          onPressed: () {
            if (_pageController.page! > 0) {
              _pageController.previousPage(
                duration: stepProcessDuration,
                curve: Curves.easeInOut,
              );
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Step1CreateGroup(),
          Step2CreateGroup(),
          Step3CreateGroup(),
          Step4CreateGroup(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumberStepper(
              totalSteps: 4,
              width: MediaQuery.of(context).size.width,
              curStep: _currentPage,
              lineWidth: 3.5,
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                if (_pageController.page! < 3) {
                  _pageController.nextPage(
                    duration: stepProcessDuration,
                    curve: Curves.easeInOut,
                  );
                } else {
                  EasyLoading.showToast("đến đây thôi chưa có API");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Tiếp",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
