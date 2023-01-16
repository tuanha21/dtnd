import 'package:get/get.dart';

import 'ekyc_state.dart';

class EkycLogic extends GetxController {
  final EkycState state = EkycState();

  Future<bool> backStep() {
    int index = EkycPageStep.values
        .indexWhere((element) => element == state.step.value);
    if (index == 0) {
      return Future.value(true);
    }
    state.step.value = EkycPageStep.values[index - 1];
    return Future.value(false);
  }

  void nextStep() {
    int index = EkycPageStep.values
        .indexWhere((element) => element == state.step.value);
    if (index > EkycPageStep.values.length) {
      return;
    }
    state.step.value = EkycPageStep.values[index + 1];
  }
}
