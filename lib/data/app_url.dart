// ignore_for_file: non_constant_identifier_names

class AppUrl {
  // Domain
  String _URL_DATA_FEED = 'https://banggia.casc.vn/';
  String _URL_DATA_FEED1 = 'https://trading.pinetree.vn/';
  String _ENDPOINT_CORE = "TraditionalService";

  String _URL_CORE = 'https://trading.casc.vn/';
  String _SIGNUP_URL = "https://motaikhoan.casc.vn";

  // String URL_CORE = 'https://tradingtest.casc.vn/';
  // String SIGNUP_URL = "https://motaikhoantest.casc.vn";

  String _URL_STOCK = 'https://info.sbsi.vn/';

  AppUrl.fromJson()
      : _URL_DATA_FEED = 'https://banggia.casc.vn/',
        _URL_DATA_FEED1 = 'https://trading.pinetree.vn/',
        _ENDPOINT_CORE = "TraditionalService",
        _URL_CORE = 'https://trading.casc.vn/',
        _SIGNUP_URL = "https://motaikhoan.casc.vn",
        _URL_STOCK = 'https://info.sbsi.vn/';
}
