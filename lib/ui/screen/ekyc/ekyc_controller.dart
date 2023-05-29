import 'package:get/get.dart';
import 'dart:io';

class EkycController extends GetxController {
  Rx<File> selectedFrontFile = Rx<File>(File(''));
  Rx<File> selectedBackFile = Rx<File>(File(''));

  void updateFrontFile(File newFile) {
    selectedFrontFile.value = newFile;
  }

  void updateBackFile(File newFile) {
    selectedBackFile.value = newFile;
  }
}
