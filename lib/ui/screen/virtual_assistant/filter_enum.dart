enum FilterEnum {
  dividend,
  valuation,
  priceAndVolume,
  operationalEfficiency,
  profitability,
  longTermSolvency,
  shortTermSolvency,
  foreignInvestors,
  scale,
  financial,
  growth,
  technicalSignals
}

extension FilterExt on FilterEnum {
  String get name {
    switch (this) {
      case FilterEnum.dividend:
        return "Cổ tức";
      case FilterEnum.valuation:
        return "Định giá";
      case FilterEnum.priceAndVolume:
        return "Giá và khối lượng";
      case FilterEnum.operationalEfficiency:
        return "Hiệu quả hoạt động";
      case FilterEnum.profitability:
        return "Khả năng sinh lời";
      case FilterEnum.longTermSolvency:
        return "Khả năng thanh toán dài hạn";
      case FilterEnum.shortTermSolvency:
        return "Khả năng thanh toán ngắn hạn";
      case FilterEnum.foreignInvestors:
        return "Khối ngoại";
      case FilterEnum.scale:
        return "Quy mô";
      case FilterEnum.financial:
        return "Sức khỏe tài chính";
      case FilterEnum.growth:
        return "Tăng trưởng";
      case FilterEnum.technicalSignals:
        return "Tín hiệu kỹ thuật";
      default:
        return "";
    }
  }

  Map<String, dynamic> get data {
    switch (this) {
      case FilterEnum.dividend:
        return {
          'DVD_PAID_RATE': "Tỷ lệ chi trả cổ tức (%)",
          'DVD_PER_P': "Tỷ suất cổ tức (%)",
          'DVD_1Y': "Cổ tức 4 quý (VND)",
          'EPS': "EPS 4 quý (VND)"
        };
      case FilterEnum.valuation:
        return {
          'PE': "PE (lần)",
          'PB': "PB (lần)",
          'PS': "PS (lần)",
          'EV_PER_EBIT': "EV/EBIT (lần)",
          'EV_PER_EBITDA': "EV/EBITDA (lần)",
          'P_PER_FCF': "P/FCF (lần)",
        };
      case FilterEnum.priceAndVolume:
        return {
          'TOTAL_VOL': "KLGD hiện tại (CP)",
          'AVG_VOL_5D': "TB KLGD 5 phiên (CP)",
          'AVG_VOL_10D': "TB KLGD 10 phiên (CP)",
          'AVG_VOL_20D': "TB KLGD 20 phiên (CP)",
          'AVG_VOL_30D': "TB KLGD 30 phiên (CP)",
          'AVG_VOL_60D': "TB KLGD 60 phiên (CP)",
          'AVG_VOL_YTD': "TB KLGD YTD (CP)",
          'AVG_VOL_1Y': "TB KLGD 1 năm (CP)",
          'TOTAL_VAL': "GTGD hiện tại (Triệu VND)",
          'AVG_VAL_5D': "TB GTGD 5 phiên (Triệu VND)",
          'AVG_VAL_10D': "TB GTGD 10 phiên (Triệu VND)",
          'AVG_VAL_20D': "TB GTGD 20 phiên (Triệu VND)",
          'AVG_VAL_30D': "TB GTGD 30 phiên (Triệu VND)",
          'AVG_VAL_60D': "TB GTGD 60 phiên (Triệu VND)",
          'AVG_VAL_YTD': "TB GTGD YTD (Triệu VND)",
          'AVG_VAL_1Y': "TB GTGD 1 năm (Triệu VND)",
          'VOL_PER_5D': "KLGD so với KLGD bình quân 5 phiên (lần)",
          'VOL_PER_10D': "KLGD so với KLGD bình quân 10 phiên (lần)",
          'VOL_PER_20D': "KLGD so với KLGD bình quân 20 phiên (lần)",
          'VOL_10D_VS_3M':
          "KLGD bình quân 10 ngày so với KLGD bình quân 3 tháng (lần)",
          'VAL_PER_5D': "GTGD so với GTGD bình quân 5 phiên (lần)",
          'VAL_PER_10D': "GTGD so với GTGD bình quân 10 phiên (lần)",
          'VAL_PER_20D': "GTGD so với GTGD bình quân 20 phiên (lần)",
          'P_PER_20D': "Giá so với MA 20 (%)",
          'P_PER_50D': "Giá so với MA 50 (%)",
          'P_PER_130D': "Giá so với MA 130 (%)",
          'P_PER_200D': "Giá so với MA 200 (%)",
          'P_CHANGE_1W': "Thay đổi giá 1 tuần (%)",
          'P_CHANGE_1M': "Thay đổi giá 1 tháng (%)",
          'P_CHANGE_3M': "Thay đổi giá 3 tháng (%)",
          'P_CHANGE_6M': 'Thay đổi giá 6 tháng (%)',
          'P_CHANGE_1Y': 'Thay đổi giá 1 năm (%)',
          'P_PER_MAX_52W': "Giá so với giá cao 52 tuần (%)",
          'P_PER_MIN_52W': "Giá so với giá thấp 52 tuần (%)",
          'BETA30D': 'Beta 30 ngày',
          'BETA60D': 'Beta 60 ngày',
          'BETA90D': 'Beta 90 ngày',
          'RS1W': 'Sức mạnh tương đương 1 tuần (%)',
          'RS1M': "Sức mạnh tương đương 1 tháng (%)",
          'RS3M': "Sức mạnh tương đương 3 tháng (%)",
          'RS6M': 'Sức mạnh tương đương 6 tháng (%)',
          'RS1Y': 'Sức mạnh tương đương 1 năm (%)',
          'STD_P_1Y': 'Độ lệch chuẩn theo ngày, 1 năm (%)',
        };
      case FilterEnum.operationalEfficiency:
        return {
          'INVENTORY_TURN': 'Hệ số quay vòng hàng tồn kho (lần)',
          'INVENTORY_DAYS': "Số ngày hàng tồn kho trong kỳ (ngày)",
          'REC_TURN':
          "Hệ số quay vòng khoản phải thu (lần)",
          'REC_DAYS': 'Số ngày phải thu trong kỳ (ngày)',
          'PAY_TURN': 'Hệ số quay vòng khoản phải trả (lần)',
          'PAY_DAYS': 'Số ngày phải trả trong kỳ (ngày)',
          'CAPITAL_TURN': 'Hệ số quay vòng vốn lưu động (lần)',
          'FIXED_ASSETS_TURN': 'Hệ số quay vòng tài sản cố định (lần)',
          'ASSETS_TURN': 'Hệ số quay vòng tổng tài sản (lần)',
        };
      case FilterEnum.profitability:
        return {
          "ROA": "ROA (%)",
          "ROE": "ROE (%)",
          "GR_MARGIN": "Biên lợi nhuận gộp (%)",
          "OPERATING_MARGIN": "Biên lợi nhuận hoạt động (%)",
          "BF_TAX_MARGIN": "Biên lợi nhuận trước thuế (%)",
          "NET_MARGIN": "Biên lợi nhuận sau thuế (%)",
          "ROIC": "ROIC (%)",
          "ROCE": "ROCE (%)"
        };
      case FilterEnum.longTermSolvency:
        return {
          "DEBT_PER_ASSETS": "Chỉ số nợ trên tổng tài sản (lần)",
          "DEBT_PER_CAPITAL": "Chỉ số nợ trên tổng nguồn vốn (lần)",
          "DEBT_PER_EQUITY": "Chỉ số nợ trên vốn chủ sở hữu (lần)",
          "LEVERAGE": "Chỉ số đòn bẩy tài chính (lần)",
          "INT_COVERAGE": "Tỉ lệ đảm bảo chi phí lãi vay (lần)",
          "CASH_PER_ASSETS": "Chỉ số tiền mặt trên tổng tài sản (lần)",
          "FCF_PER_LT_DEBT": "Chỉ số FCF trên nợ dài hạn (lần)",
          "NET_DEBT_PER_EQUITY": "Chỉ số nợ ròng trên vốn chủ sở hữu (lần)",
          "NET_DEBT_PER_TANGIBLE_EQUITY":
          "Chỉ số nợ ròng trên vốn chủ sở hữu hữu hình (lần)",
          "LT_DEBT_PER_ASSETS": "Chỉ số nợ dài hạn trên tổng tài sản (lần)",
          "TANGIBLE_ASSETS_PER_EQUITY":
          "Chỉ số tài sản hữu hình trên vốn chủ sở hữu (lần)",
          "NET_DEBT_PER_MC": "Chỉ số nợ ròng trên vốn hóa (lần)",
          "NET_DEBT_PER_TANGIBLE_ASSETS":
          "Chỉ số nợ ròng trên tài sản hữu hình (lần)"
        };
      case FilterEnum.shortTermSolvency:
        return {
          "CURR_RATIO": "Chỉ số thanh toán ngắn hạn (lần)",
          "QUICK_RATIO": "Chỉ số thanh toán nhanh (lần)",
          "CASH_RATIO": "Chỉ số thanh toán tiền mặt (lần)",
          "CASH_TURN": "Vòng quay tiền mặt (lần)",
        };
      case FilterEnum.foreignInvestors:
        return {
          "F_SELL_VALUE" : "Giá trị bán khối ngoại (triệu VND)",
          "F_BUY_VALUE": "Giá trị mua khối ngoại (triệu VND)",
          "F_NET_BUY_VALUE": "Giá trị mua ròng khối ngoại (triệu VND)",
          "F_BUY_VAL_PER_5D": "GT mua khối ngoại so với TB 5 phiên trước (lần)",
          "F_BUY_VAL_PER_10D":
          "GT mua khối ngoại so với TB 10 phiên trước (lần)",
          "F_BUY_VAL_PER_20D":
          "GT mua khối ngoại so với TB 20 phiên trước (lần)",
          "F_SELL_VAL_PER_5D":
          "GT bán khối ngoại so với TB 5 phiên trước (lần)",
          "F_SELL_VAL_PER_10D":
          "GT bán khối ngoại so với TB 10 phiên trước (lần)",
          "F_SELL_VAL_PER_20D":
          "GT bán khối ngoại so với TB 20 phiên trước (lần)",
          "F_NET_BUY_VOLUME": "KL mua ròng khối ngoại (CP)",
          "AVG_F_NET_BUY_VOL_5D": "KL mua ròng khối ngoại TB 5 phiên (CP)",
          "AVG_F_NET_BUY_VOL_10D": "KL mua ròng khối ngoại TB 10 phiên (CP)",
          "AVG_F_NET_BUY_VOL_20D": "KL mua ròng khối ngoại TB 20 phiên (CP)",
          "AVG_F_NET_BUY_VOL_30D": "KL mua ròng khối ngoại TB 30 phiên (CP)",
          "AVG_F_NET_BUY_VOL_60D": "KL mua ròng khối ngoại TB 60 phiên (CP)",
          "AVG_F_NET_BUY_VOL_YTD": "KL mua ròng khối ngoại TB YTD (CP)",
          "AVG_F_NET_BUY_VOL_1Y": "GT mua ròng khối ngoại (Triệu VND)",
          "AVG_F_NET_BUY_5D": "GT mua ròng khối ngoại TB 5 phiên (Triệu VND)",
          "AVG_F_NET_BUY_10D": "GT mua ròng khối ngoại TB 10 phiên (Triệu VND)",
          "AVG_F_NET_BUY_20D": "GT mua ròng khối ngoại TB 20 phiên (Triệu VND)",
          "AVG_F_NET_BUY_30D": "GT mua ròng khối ngoại TB 30 phiên (Triệu VND)",
          "AVG_F_NET_BUY_60D": "GT mua ròng khối ngoại TB 60 phiên (Triệu VND)",
          "AVG_F_NET_BUY_YTD": "GT mua ròng khối ngoại TB YTD (Triệu VND)",
          "AVG_F_NET_BUY_1Y": "GT mua ròng khối ngoại TB 1 năm (Triệu VND)",
        };
      case FilterEnum.scale:
        return {
          "MC": "Vốn hóa (tỷ VND)",
          "EV": "EV (tỷ VND)",
        };
      case FilterEnum.financial:
        return {
          "M_SCORE": "M-Score",
          "F_SCORE": "F-Score",
          "Z_SCORE": "Z-Score",
          "C_SCORE": "C-Score",
          "MAGIC_SCORE": "Magic Formula Score",
        };
      case FilterEnum.growth:
        return {
          "NET_INC_GROWTH":
          "Tăng trưởng LN ròng 4 quý gần nhất so với 4 quý trước (%)",
          "EPS_GROWTH": "Tăng trưởng EPS 4 quý gần nhất so với 4 quý trước (%)",
          "REV_GROWTH_1Y":
          "Tăng trưởng doanh thu 4 quý gần nhất so với 4 quý trước (%)",
          "DVD_GROWTH": "Tăng trưởng DPS 4 quý gần nhất so với 4 quý trước (%)",
          "OPERATING_INC_GROWTH":
          "Tăng trưởng LN từ hoạt động kinh doanh 4 quý gần nhất so với 4 quý trước (%)",
          "GR_PROFIT_GROWTH":
          "Tăng trưởng LN gộp 4 quý gần nhất so với 4 quý trước (%)",
          "NET_INC_GROWTH1":
          "Tăng trưởng LN ròng quý gần nhất so với quý cùng kỳ năm trước (%)",
          "REV_GROWTH1":
          "Tăng trưởng doanh thu quý gần nhất so với quý cùng kỳ năm trước (%)",
          "OPERATING_INC_GROWTH1":
          "Tăng trưởng LN từ HĐKD quý gần nhất so với quý cùng kỳ năm trước (%)",
          "GR_PROFIT_GROWTH1":
          "Tăng trưởng LN gộp quý gần nhất so với quý cùng kỳ năm trước (%)",
        };
      case FilterEnum.technicalSignals:
        return {
          "RSI_14": "RSI (14)",
          "STOCHASTIC_14_3_3": "STOCH (14)",
          "ADI_14": "ADX (14)",
          "STOCHASTIC_RSI_14": "STOCHRSI (14)",
          "ATR_14": "ATR (14)",
          "WILLIAMR_14": "William %R (14)",
          "MACD_12_26_9": "MACD (12,26,9)",
          "MFI_14": "MFI (14)",
          "BBAND_20_2": "Bollinger Band %B (20,2)",
          "MA_ENVELOPES_20_25": "Moving Average Envelopes (20,2.5) %E",
          "P_PER_SMA10": "Giá so với SMA (10) (%)",
          "P_PER_EMA10": "Giá so với EMA (10) (%)",
          "P_PER_DEMA10": "Giá so với DEMA (10) (%)",
          "P_PER_WMA10": "Giá so với WMA (10) (%)",
          "SMA5_PER_SMA20": "SMA (5) so với SMA (20) (%)",
          "EMA5_PER_EMA20": "EMA (5) so với EMA (20) (%)",
          "DEMA5_PER_DEMA20": "DEMA (5) so với DEMA (20) (%)",
          "WMA5_PER_WMA20": "WMA (5) so với WMA (20) (%)",
        };
      default:
        return {};
    }
  }
}
