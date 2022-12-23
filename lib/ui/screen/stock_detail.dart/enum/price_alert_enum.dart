enum PriceAlertButton {
  down5Pc,
  down10Pc,
  up5Pc,
  up10Pc,
}

extension PriceAlertButtonX on PriceAlertButton {
  String get name {
    switch (this) {
      case PriceAlertButton.down5Pc:
        return "-5%";
      case PriceAlertButton.down10Pc:
        return "-10%";
      case PriceAlertButton.up5Pc:
        return "+5%";
      case PriceAlertButton.up10Pc:
        return "+10%";
    }
  }

  num get value {
    switch (this) {
      case PriceAlertButton.down5Pc:
        return -5;
      case PriceAlertButton.down10Pc:
        return -10;
      case PriceAlertButton.up5Pc:
        return 5;
      case PriceAlertButton.up10Pc:
        return 10;
    }
  }
}
