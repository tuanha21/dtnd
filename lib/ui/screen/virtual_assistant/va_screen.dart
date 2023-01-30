import 'dart:async';

import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_filter/virtual_assistant_filter_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_register/va_register.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/va_volatolity_warning_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:msgpack_dart/msgpack_dart.dart' as msgp;

enum VAFeature {
  stockFilter,
  volatilityWarning,
}

extension VirtualAssistantFeatureX on VAFeature {
  String get name {
    switch (this) {
      case VAFeature.stockFilter:
        return S.current.filter_stock;
      case VAFeature.volatilityWarning:
        return S.current.volatility_warning;
    }
  }

  String get iconPath {
    switch (this) {
      case VAFeature.stockFilter:
        return AppImages.chart2_icon;
      case VAFeature.volatilityWarning:
        return AppImages.directbox_receive_icon;
    }
  }

  VoidCallback onPressed(BuildContext context) {
    switch (this) {
      case VAFeature.stockFilter:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AssistantStockFilterScreen(),
            ));
      case VAFeature.volatilityWarning:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const VAVolatilityWarningScreen(),
            ));
    }
  }
}

class VAScreen extends StatefulWidget {
  const VAScreen({super.key});

  @override
  State<VAScreen> createState() => _VAScreenState();
}

class _VAScreenState extends State<VAScreen> {
  bool initialized = false;
  WebSocketChannel? channel;
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    final registered = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const VARegister(),
    ));
    if (registered) {
      print("setState");
      setState(() {
        initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerRight,
          child: SizedBox.square(
            dimension: 32,
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: themeMode.isLight
                      ? AppColors.neutral_05
                      : AppColors.neutral_01,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primary_01,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          S.of(context).DTND_assistant,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: VAFeature.values.length,
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  Widget child = Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox.square(
                        dimension: 24,
                        child: Image.asset(VAFeature.values[index].iconPath),
                      ),
                      Text(
                        VAFeature.values[index].name,
                      )
                    ],
                  );
                  child = InkWell(
                    onTap: VAFeature.values[index].onPressed(context),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      // width: 102,
                      // height: 52,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: child,
                    ),
                  );

                  // TextButton(
                  //     onPressed: VirtualAssistantFeature.values[index]
                  //         .onPressed(context),
                  //     child: Text(VirtualAssistantFeature.values[index].name));
                  return child;
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 8,
                ),
              ),
            ),
            Text(S.of(context).virtual_assistant),
            SizedBox(
              width: Responsive.getMaxWidth(context) - 32,
              child: TextButton(
                onPressed: connectWs,
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                child: const Text("Connect WS"),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Responsive.getMaxWidth(context) - 32,
              child: TextButton(
                onPressed: disconnectWs,
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                child: const Text("Disconnect WS"),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Responsive.getMaxWidth(context) - 32,
              child: TextButton(
                onPressed: sendMsg,
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                child: const Text("Send msg"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMsg() {
    channel?.sink.add(msgp.serialize({"msg": "ping"}));
  }

  void connectWs() async {
    try {
      if (channel != null) {
        SnackBar snackBar = const SnackBar(
          content: Text("Already connected"),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.100.58:8888'),
      );
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        print("ping");
        // channel!.sink.add("ping");
        channel!.sink.add(msgp.serialize({"msg": "ping"}));
        // channel!.sink.addError("addError");
      });
      SnackBar snackBar = const SnackBar(
        content: Text("Connected"),
      );
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      channel?.stream.listen(
        (event) {
          print(event);
          // if (event is String) {
          //   return;
          // }

          // final u = Unpacker.fromList(event);
          final msg = msgp.deserialize(event);
          print(msg);
          // final msg1 = msgp.deserialize(msg);
          // print(u);
          // print(msg1);
          // final i = u.unpackMapLength();
          // print(i);
          // final c = u.unpackMap();
          // print(c);
          // if (u.runtimeType) {

          // }
          // final r = jsonDecode(u);
          // print(r['Key_0']);
          // final id = u.unpackString();
          // logger.v(id);
          // final userId = u.unpackString();
          // print(userId);
          // logger.v(userId);
        },
        onError: (error) => logger.e("onError"),
        onDone: () {
          disconnectWs();
          print("disconnected");
        },
      );
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void disconnectWs() async {
    try {
      if (channel == null) {
        SnackBar snackBar = const SnackBar(
          content: Text("Already disconnected"),
        );
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      timer?.cancel();
      channel!.sink.close();
      channel = null;

      SnackBar snackBar = const SnackBar(
        content: Text("Disconnected"),
      );
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
      );

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
