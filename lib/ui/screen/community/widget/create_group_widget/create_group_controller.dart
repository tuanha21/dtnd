import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupController {
  static final CreateGroupController _instance =
      CreateGroupController._intern();

  CreateGroupController._intern();

  factory CreateGroupController() => _instance;

  final Rx<File?> imageAvatar = Rx<File?>(null);
  final Rx<File?> imageBackground = Rx<File?>(null);

  Future<void> pickImageAvatar() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageAvatar.value = File(pickedImage.path);
    }
  }

  Future<void> pickImageBackground() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageBackground.value = File(pickedImage.path);
    }
  }
}
