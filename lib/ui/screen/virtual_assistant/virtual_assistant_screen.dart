import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/virtual_assistant_register/virtual_assistant_register.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VirtualAssistantScreen extends StatefulWidget {
  const VirtualAssistantScreen({super.key});

  @override
  State<VirtualAssistantScreen> createState() => _VirtualAssistantScreenState();
}

class _VirtualAssistantScreenState extends State<VirtualAssistantScreen> {
  bool initialized = false;
  WebSocketChannel? channel;

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
        title: Text(S.of(context).DTND_assistant),
      ),
      body: Center(
        child: Column(
          children: [
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
          ],
        ),
      ),
    );
  }

  void connectWs() async {
    try {
      if (channel != null) {
        SnackBar snackBar = const SnackBar(
          content: Text("Already connected"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.100.58:1234'),
      );
      SnackBar snackBar = const SnackBar(
        content: Text("Connected"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      channel?.stream.listen((event) {
        logger.v(event.toString());
      });
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
