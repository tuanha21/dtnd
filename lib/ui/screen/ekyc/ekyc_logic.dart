import 'package:get/get.dart';

import 'ekyc_state.dart';

class EkycLogic extends GetxController {
  final EkycState state = EkycState();

  void backStep() {
    int index = EkycPageStep.values
        .indexWhere((element) => element == state.step.value);
    if (index == 0) {
      return;
    }
    state.step.value = EkycPageStep.values[index - 1];
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
