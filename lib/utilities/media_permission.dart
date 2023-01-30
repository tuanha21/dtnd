import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaPermission {
  static var picker = ImagePicker();

  static Future<File?> checkPermissionAndPickImage(
    BuildContext context,
    String type,
  ) async {
    if (Platform.isAndroid) {
      if (type == 'gallery') {
        final Map<Permission, PermissionStatus> request =
            await [Permission.storage].request();
        if (request[Permission.storage] == PermissionStatus.permanentlyDenied) {
          final openSetting = await bottomDialog(
            context,
            'Dtnd muốn truy cập thư viện của bạn',
            'Điều này sẽ cho phép ứng dụng truy cập thư viện của bạn',
          );
          if (openSetting == true) {
            await openAppSettings();
            return null;
          }
        }
        if (request[Permission.storage] == PermissionStatus.restricted) {
          await bottomErrorDialog(context);
          return null;
        }
        if (request[Permission.storage] == PermissionStatus.granted) {
          return cropImage(await getImage(ImageSource.gallery));
        }
      }
      if (type == 'camera') {
        final Map<Permission, PermissionStatus> request =
            await [Permission.camera].request();
        if (request[Permission.camera] == PermissionStatus.permanentlyDenied) {
          final openSetting = await bottomDialog(
            context,
            'Dtnd muốn sử dụng camera',
            'Điều này sẽ cho phép ứng dụng sử dụng camera',
          );
          if (openSetting == true) {
            await openAppSettings();
            return null;
          }
        }
        if (request[Permission.camera] == PermissionStatus.restricted) {
          await bottomErrorDialog(context);
          return null;
        }
        if (request[Permission.camera] == PermissionStatus.granted) {
          return await getImage(ImageSource.camera);
        }
      }
    }
    if (Platform.isIOS) {
      if (type == 'gallery') {
        final Map<Permission, PermissionStatus> request =
            await [Permission.photos].request();
        if (request[Permission.photos] != PermissionStatus.granted) {
          final openSetting = await bottomDialog(
            context,
            'TaxiMb sme muốn truy cập thư viện của bạn',
            'Điều này sẽ cho phép ứng dụng truy cập thư viện của bạn',
          );
          if (openSetting == true) {
            await openAppSettings();
          }
        } else if (request[Permission.photos] == PermissionStatus.restricted) {
          await bottomErrorDialog(context);
        } else if (request[Permission.photos] == PermissionStatus.granted) {
          return await getImage(ImageSource.gallery);
        }
      }
      if (type == 'camera') {
        return await getImage(ImageSource.camera);
      }
    }
    return null;
  }

  static Future<File?> getImage(ImageSource imageSource) async {
    try {
      final pickedFile =
          await picker.pickImage(source: imageSource, imageQuality: 60);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      throw (e.toString());
    }
    return null;
  }

  static Future<bool> bottomDialog(
      BuildContext context, String title, String content) async {
    final bool openSetting = await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Không cho phép'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Cho phép'),
          ),
        ],
      ),
    );
    return openSetting;
  }

  static Future bottomErrorDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
          title: const Text('Có lỗi xảy ra!'),
          content: const Text('Quyền truy cập đã bị từ chối.'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context, false),
              child: const Text('OK'),
            ),
          ]),
    );
  }

  static Future<File?> cropImage(File? file) async {
    if (file == null) return null;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }
}
