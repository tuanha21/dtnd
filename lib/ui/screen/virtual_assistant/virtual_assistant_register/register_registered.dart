import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';

class RegisterRegistered extends StatefulWidget {
  const RegisterRegistered({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  State<RegisterRegistered> createState() => _RegisterRegisteredState();
}

class _RegisterRegisteredState extends State<RegisterRegistered> {
  bool accepted = false;

  void switchTermAgreement(bool? newValue) {
    setState(() {
      accepted = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Responsive.getMaxWidth(context) / 3,
            child: Image.asset(
              AppImages.virtual_assistant_registered,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).successfully_create_assistant_account,
            textAlign: TextAlign.center,
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Text(
            S
                .of(context)
                .the_DTND_virtual_assistant_will_help_you_with_successful_transaction,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: Responsive.getMaxWidth(context) - 32,
            child: TextButton(
              onPressed: widget.nextPage,
              style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
              child: Text(S.of(context).next),
            ),
          ),
        ],
      ),
    );
  }
}
