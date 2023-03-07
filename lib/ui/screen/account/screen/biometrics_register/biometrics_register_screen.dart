import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsRegisterScreen extends StatefulWidget {
  const BiometricsRegisterScreen({super.key});

  @override
  State<BiometricsRegisterScreen> createState() =>
      _BiometricsRegisterScreenState();
}

class _BiometricsRegisterScreenState extends State<BiometricsRegisterScreen> {
  final ILocalStorageService localStorageService = LocalStorageService();
  bool reg = false;

  @override
  void initState() {
    super.initState();
    if (localStorageService.biometricsRegistered) {
      reg = true;
    }
  }

  void onChanged(bool value) async {
    setState(() {
      reg = value;
    });
    if (value) {
      final auth = await localStorageService
          .biometricsValidate()
          .onError((error, stackTrace) => false);
      if (auth) {
        await localStorageService.registerBiometrics();
      } else {
        setState(() {
          reg = false;
        });
      }
    } else {
      final auth = await localStorageService
          .biometricsValidate()
          .onError((error, stackTrace) => false);
      if (auth) {
        await localStorageService.cancelBiometrics();
      } else {
        setState(() {
          reg = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppbar(
        title: "Face/Touch ID",
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Ink(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Face/Touch ID"),
                      Switch.adaptive(value: reg, onChanged: onChanged)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
