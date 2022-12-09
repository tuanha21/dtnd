import 'dart:async';
import 'dart:convert';

import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_filter/virtual_assistant_filter_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_register/virtual_assistant_register.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:messagepack/messagepack.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:msgpack_dart/msgpack_dart.dart' as msgp;

enum VirtualAssistantFeature {
  stockFilter,
}

extension VirtualAssistantFeatureX on VirtualAssistantFeature {
  String get name {
    switch (this) {
      case VirtualAssistantFeature.stockFilter:
        return "Lọc cổ phiếu";
    }
  }

  VoidCallback onPressed(BuildContext context) {
    switch (this) {
      case VirtualAssistantFeature.stockFilter:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AssistantStockFilterScreen(),
            ));
    }
  }
}

class VirtualAssistantScreen extends StatefulWidget {
  const VirtualAssistantScreen({super.key});

  @override
  State<VirtualAssistantScreen> createState() => _VirtualAssistantScreenState();
}

class _VirtualAssistantScreenState extends State<VirtualAssistantScreen> {
  bool initialized = false;
  WebSocketChannel? channel;
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    final registered = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const VirtualAssistantRegister(),
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
              height: 50,
              child: ListView.builder(
                itemCount: VirtualAssistantFeature.values.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => TextButton(
                    onPressed: VirtualAssistantFeature.values[index]
                        .onPressed(context),
                    child: Text(VirtualAssistantFeature.values[index].name)),
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
