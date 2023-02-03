import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';

class RegisterIntro extends StatefulWidget {
  const RegisterIntro({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  State<RegisterIntro> createState() => _RegisterIntroState();
}

class _RegisterIntroState extends State<RegisterIntro> {
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
              AppImages.virtual_assistant_register,
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            S.of(context).virtual_assistant_available,
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: accepted,
                onChanged: switchTermAgreement,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(text: S.of(context).agree_with),
                TextSpan(text: S.of(context).term),
                TextSpan(text: S.of(context).DTNDs_virtual_assistant),
              ])),
            ],
          ),
          Builder(builder: (context) {
            late final VoidCallback? canNext;
            if (accepted) {
              canNext = () => widget.nextPage.call();
            } else {
              canNext = null;
            }

            return SizedBox(
              width: Responsive.getMaxWidth(context) - 32,
              child: TextButton(
                onPressed: canNext,
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                child: Text(S.of(context).create_account),
              ),
            );
          }),
        ],
      ),
    );
  }
}