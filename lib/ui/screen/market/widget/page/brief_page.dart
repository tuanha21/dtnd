import 'package:dtnd/=models=/fake/brief_model.dart';
import 'package:dtnd/ui/screen/market/widget/components/brief_suggestion_fab.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BriefPage extends StatefulWidget {
  const BriefPage({super.key, required this.data});
  final BriefModel data;
  @override
  State<BriefPage> createState() => _BriefPageState();
}

class _BriefPageState extends State<BriefPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Brief",
          style: AppTextStyle.titleLarge_18,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BriefSuggestionFAB(
        data: widget.data.contentFull!.recommendForMorningNews!,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    size: 12,
                  ),
                  const SizedBox(width: 2),
                  Builder(builder: (context) {
                    final DateFormat format = DateFormat("dd/MM/yyyy");

                    return Text(
                      format.format(widget.data.regDateTime!),
                      // textAlign: TextAlign.end,
                      style: AppTextStyle.bottomNavLabel
                          .copyWith(color: AppColors.neutral_03),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    widget.data.contentFull!.title!,
                    style: AppTextStyle.headlineSmall_24,
                  ))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "XU HƯỚNG VNINDEX TRONG NGÀY",
                    style: AppTextStyle.titleLarge_18,
                  ))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    widget.data.contentFull!.trend!,
                    // style: AppTextStyle.titleMedium_16,
                  ))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "CHIẾN LƯỢC GIAO DỊCH VÀ KHUYẾN NGHỊ",
                    style: AppTextStyle.titleLarge_18,
                  ))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "BUY ",
                      style: AppTextStyle.titleMedium_16
                          .copyWith(color: AppColors.semantic_01),
                    ),
                    TextSpan(
                      text: widget.data.contentFull!.buyStrategy!,
                    )
                  ])
                          // style: AppTextStyle.titleMedium_16,
                          ))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "SELL ",
                      style: AppTextStyle.titleMedium_16
                          .copyWith(color: AppColors.semantic_03),
                    ),
                    TextSpan(
                      text: widget.data.contentFull!.sellStrategy!,
                    )
                  ])
                          // style: AppTextStyle.titleMedium_16,
                          ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
