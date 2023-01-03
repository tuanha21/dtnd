// ignore_for_file: constant_identifier_names

import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';

enum DetailTab {
  Overview,
  TechnicalAnalysis,
  FinancialIndex,
}

extension DetailTabX on DetailTab {
  String getName(BuildContext context) {
    switch (this) {
      case DetailTab.Overview:
        return S.of(context).overview;
      case DetailTab.TechnicalAnalysis:
        return S.of(context).technical_analysis;
      case DetailTab.FinancialIndex:
        return S.of(context).financial_index;
    }
  }
}
