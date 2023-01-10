// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(name) =>
      "Bạn có chắc chắn muốn xóa danh mục “${name}” không ?";

  static String m1(name) => "Danh mục theo dõi \"${name}\"";

  static String m2(value) => "Tăng ${value}";

  static String m3(value) => "Giảm ${value}";

  static String m4(value) =>
      "Mã OTP đã được gửi về số điện thoại đuôi ${value} của bạn. Nhập mã 6 số để tiếp tục.";

  static String m5(name) => "Sửa tên danh mục “${name}” thành";

  static String m6(value) => "Tổng ${value}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Banking": MessageLookupByLibrary.simpleMessage("Ngân hàng"),
        "Carriage": MessageLookupByLibrary.simpleMessage("Vận tải"),
        "Chemistry": MessageLookupByLibrary.simpleMessage("Hóa chất"),
        "Cigarette": MessageLookupByLibrary.simpleMessage("Thuốc lá"),
        "DTND_assistant": MessageLookupByLibrary.simpleMessage("Trợ lý DTND"),
        "DTNDs_virtual_assistant":
            MessageLookupByLibrary.simpleMessage(" của trợ lý ảo DTND"),
        "Extractive": MessageLookupByLibrary.simpleMessage("Khai khoáng"),
        "Medicine": MessageLookupByLibrary.simpleMessage("Dược phẩm"),
        "Metal": MessageLookupByLibrary.simpleMessage("Kim loại"),
        "Retail": MessageLookupByLibrary.simpleMessage("Bán lẻ"),
        "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "account_notice":
            MessageLookupByLibrary.simpleMessage("Thông báo tài khoản"),
        "add_catalog": MessageLookupByLibrary.simpleMessage("Thêm danh mục"),
        "add_following_stock":
            MessageLookupByLibrary.simpleMessage("Thêm mã theo dõi"),
        "add_stock": MessageLookupByLibrary.simpleMessage("Thêm mã"),
        "agree_with": MessageLookupByLibrary.simpleMessage("Đồng ý với "),
        "analysis": MessageLookupByLibrary.simpleMessage("Phân tích"),
        "are_you_sure_to_delete_catalog": m0,
        "asset": MessageLookupByLibrary.simpleMessage("Tài sản"),
        "average": MessageLookupByLibrary.simpleMessage("Trung bình"),
        "bond": MessageLookupByLibrary.simpleMessage("Trái phiếu"),
        "buy": MessageLookupByLibrary.simpleMessage("Mua"),
        "buy_price": MessageLookupByLibrary.simpleMessage("Giá mua vào"),
        "cancel": MessageLookupByLibrary.simpleMessage("Huỷ"),
        "cash_flow": MessageLookupByLibrary.simpleMessage("Dòng tiền"),
        "catalog_name": MessageLookupByLibrary.simpleMessage("Tên danh mục"),
        "catalog_notice":
            MessageLookupByLibrary.simpleMessage("Thông báo danh mục"),
        "ceil": MessageLookupByLibrary.simpleMessage("Trần"),
        "choose_stocks_you_interested": MessageLookupByLibrary.simpleMessage(
            "Chọn các mã CK mà bạn đang quan tâm. Bạn có thể cập nhật thêm các mã CK sau"),
        "community": MessageLookupByLibrary.simpleMessage("Cộng đồng"),
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "copytrade": MessageLookupByLibrary.simpleMessage("Copytrade"),
        "create": MessageLookupByLibrary.simpleMessage("Tạo"),
        "create_account": MessageLookupByLibrary.simpleMessage("Tạo tài khoản"),
        "create_catalog": MessageLookupByLibrary.simpleMessage("Tạo danh mục"),
        "create_new_order":
            MessageLookupByLibrary.simpleMessage("Đặt lệnh mới"),
        "create_order_successfully":
            MessageLookupByLibrary.simpleMessage("Đặt lệnh thành công"),
        "delete_catalog": MessageLookupByLibrary.simpleMessage("Xoá danh mục"),
        "dividend": MessageLookupByLibrary.simpleMessage("Cổ tức"),
        "double_back_to_close_app":
            MessageLookupByLibrary.simpleMessage("Ấn thêm lần nữa để thoát"),
        "edit_catalog_name":
            MessageLookupByLibrary.simpleMessage("Sửa tên danh mục"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "empty_catalog": MessageLookupByLibrary.simpleMessage("Danh mục rỗng"),
        "event": MessageLookupByLibrary.simpleMessage("Sự kiện"),
        "exchange_total":
            MessageLookupByLibrary.simpleMessage("Tổng giao dịch"),
        "fbuy": MessageLookupByLibrary.simpleMessage("NN mua"),
        "fill_OTP": MessageLookupByLibrary.simpleMessage("Nhập mã OTP"),
        "fill_account": MessageLookupByLibrary.simpleMessage("Nhập tài khoản"),
        "fill_password": MessageLookupByLibrary.simpleMessage("Nhập mật khẩu"),
        "filter_stock": MessageLookupByLibrary.simpleMessage("Lọc cổ phiếu"),
        "filter_stock_figure":
            MessageLookupByLibrary.simpleMessage("Chỉ số lọc cổ phiếu"),
        "financial_index":
            MessageLookupByLibrary.simpleMessage("Chỉ số tài chính"),
        "floor": MessageLookupByLibrary.simpleMessage("Sàn"),
        "following_catalog":
            MessageLookupByLibrary.simpleMessage("Danh mục theo dõi"),
        "following_catalog_with": m1,
        "froom": MessageLookupByLibrary.simpleMessage("Room NN"),
        "fsell": MessageLookupByLibrary.simpleMessage("NN bán"),
        "full_name": MessageLookupByLibrary.simpleMessage("Họ và tên"),
        "gain_wvalue": m2,
        "hello": MessageLookupByLibrary.simpleMessage("Chào bạn"),
        "hi": MessageLookupByLibrary.simpleMessage("Xin chào"),
        "hi_you": MessageLookupByLibrary.simpleMessage("Chào bạn"),
        "high": MessageLookupByLibrary.simpleMessage("Cao"),
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "industry": MessageLookupByLibrary.simpleMessage("Ngành"),
        "industry_list":
            MessageLookupByLibrary.simpleMessage("Danh sách ngành"),
        "interested": MessageLookupByLibrary.simpleMessage("Quan tâm"),
        "interested_catalog":
            MessageLookupByLibrary.simpleMessage("Danh mục quan tâm"),
        "invalid_account": MessageLookupByLibrary.simpleMessage(
            "Tài khoản chưa đăng ký hoặc đã hết hiệu lực giao dịch Internet"),
        "liquidity": MessageLookupByLibrary.simpleMessage("Thanh khoản"),
        "loading": MessageLookupByLibrary.simpleMessage("Đang tải..."),
        "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "login_exception_required_OTP": MessageLookupByLibrary.simpleMessage(
            "Hãy đăng nhập bằng mã OTP được gửi về máy của bạn"),
        "login_qoute1": MessageLookupByLibrary.simpleMessage(
            "Cùng tham gia thị trường đầu tư đầy sôi động với ứng dụng "),
        "login_qoute2": MessageLookupByLibrary.simpleMessage(" bạn nhé"),
        "login_required":
            MessageLookupByLibrary.simpleMessage("Yêu cầu đăng nhập"),
        "login_to_continue":
            MessageLookupByLibrary.simpleMessage("Hãy đăng nhập để tiếp tục"),
        "login_upper": MessageLookupByLibrary.simpleMessage("ĐĂNG NHẬP"),
        "login_with_facebook":
            MessageLookupByLibrary.simpleMessage("Đăng nhập với Facebook"),
        "login_with_google":
            MessageLookupByLibrary.simpleMessage("Đăng nhập với Google"),
        "loss_wvalue": m3,
        "low": MessageLookupByLibrary.simpleMessage("Thấp"),
        "market": MessageLookupByLibrary.simpleMessage("Thị trường"),
        "market_breadth":
            MessageLookupByLibrary.simpleMessage("Độ rộng thị trường"),
        "market_deep":
            MessageLookupByLibrary.simpleMessage("Độ sâu thị trường"),
        "market_overview":
            MessageLookupByLibrary.simpleMessage("Tổng quan thị trường"),
        "market_today":
            MessageLookupByLibrary.simpleMessage("Thị trường hôm nay"),
        "matched_order_detail":
            MessageLookupByLibrary.simpleMessage("Chi tiết khớp lệnh"),
        "matched_price": MessageLookupByLibrary.simpleMessage("Giá khớp"),
        "matched_vol": MessageLookupByLibrary.simpleMessage("KL khớp"),
        "minutes": MessageLookupByLibrary.simpleMessage(" phút"),
        "net_assets": MessageLookupByLibrary.simpleMessage("Tài sản ròng"),
        "news": MessageLookupByLibrary.simpleMessage("Tin tức"),
        "news_and_events":
            MessageLookupByLibrary.simpleMessage("Tin tức, sự kiện"),
        "next": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
        "no_internet":
            MessageLookupByLibrary.simpleMessage("Không có kết nối Internet"),
        "null_password": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu cần tối thiểu 8 ký tự"),
        "null_username": MessageLookupByLibrary.simpleMessage(
            "Tên đăng nhập cần tối thiểu 6 ký tự"),
        "order": MessageLookupByLibrary.simpleMessage("Đặt lệnh"),
        "order_confirm": MessageLookupByLibrary.simpleMessage("Xác nhận lệnh"),
        "order_type": MessageLookupByLibrary.simpleMessage("Loại lệnh"),
        "order_will_appear_in_ur_order_note":
            MessageLookupByLibrary.simpleMessage(
                "Lệnh đặt sẽ xuất hiện trong sổ lệnh của bạn"),
        "otp_code_sent_to_phone_number": m4,
        "overview": MessageLookupByLibrary.simpleMessage("Tổng quan"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "period_of_validity":
            MessageLookupByLibrary.simpleMessage("Thời gian hiệu lực"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "pin_code": MessageLookupByLibrary.simpleMessage("Mã pin"),
        "price": MessageLookupByLibrary.simpleMessage("Giá"),
        "price_alert": MessageLookupByLibrary.simpleMessage("Cảnh báo giá"),
        "qa_base": MessageLookupByLibrary.simpleMessage("Cơ sở"),
        "qa_bond": MessageLookupByLibrary.simpleMessage("Trái phiếu"),
        "qa_copytrade": MessageLookupByLibrary.simpleMessage("Copytrade"),
        "qa_derivative": MessageLookupByLibrary.simpleMessage("Phái sinh"),
        "qa_money": MessageLookupByLibrary.simpleMessage("Tiền gửi"),
        "qa_pack_enrol": MessageLookupByLibrary.simpleMessage("ĐK gói"),
        "ref": MessageLookupByLibrary.simpleMessage("TC"),
        "rename_catalog_to": m5,
        "save": MessageLookupByLibrary.simpleMessage("Lưu"),
        "search_stock": MessageLookupByLibrary.simpleMessage("Tìm mã CP"),
        "see_more": MessageLookupByLibrary.simpleMessage("Xem thêm"),
        "sell": MessageLookupByLibrary.simpleMessage("Bán"),
        "sell_price": MessageLookupByLibrary.simpleMessage("Giá bán ra"),
        "session_expired_in":
            MessageLookupByLibrary.simpleMessage("Hết phiên đăng nhập sau "),
        "sign_up": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "something_went_wrong":
            MessageLookupByLibrary.simpleMessage("Đã có lỗi xảy ra"),
        "stock_already_exist": MessageLookupByLibrary.simpleMessage(
            "Mã đã tồn tại trong danh mục"),
        "stocks_you_interested":
            MessageLookupByLibrary.simpleMessage("Các mã CK mà bạn quan tâm"),
        "successfully_create_assistant_account":
            MessageLookupByLibrary.simpleMessage(
                "Tạo tài khoản\ntrợ lý ảo thành công"),
        "technical_analysis":
            MessageLookupByLibrary.simpleMessage("Phân tích kỹ thuật"),
        "technical_trading_newbie": MessageLookupByLibrary.simpleMessage(
            "Bạn là 1 newbie và muốn giao dịch dễ dàng hơn"),
        "technical_trading_pro": MessageLookupByLibrary.simpleMessage(
            "Bạn giao dịch như 1 nhà đầu tư Chuyên nghiệp"),
        "term": MessageLookupByLibrary.simpleMessage("điều khoản"),
        "the_DTND_virtual_assistant_will_help_you_with_successful_transaction":
            MessageLookupByLibrary.simpleMessage(
                "Trợ lý ảo DTND sẽ giúp bạn có những\ngiao dịch thành công"),
        "time": MessageLookupByLibrary.simpleMessage("Thời gian"),
        "timeout": MessageLookupByLibrary.simpleMessage(
            "Không nhận được phản hồi từ máy chủ"),
        "top_influence": MessageLookupByLibrary.simpleMessage("Top ảnh hưởng"),
        "total_asset": MessageLookupByLibrary.simpleMessage("Tổng tài sản"),
        "total_wvalue": m6,
        "trading": MessageLookupByLibrary.simpleMessage("Giao dịch"),
        "trading_board": MessageLookupByLibrary.simpleMessage("Bảng giá"),
        "unknown_error":
            MessageLookupByLibrary.simpleMessage("Lỗi không xác định"),
        "username": MessageLookupByLibrary.simpleMessage("Tên đăng nhập"),
        "virtual_assistant": MessageLookupByLibrary.simpleMessage("Trợ lý ảo"),
        "virtual_assistant_available":
            MessageLookupByLibrary.simpleMessage("Trợ lý ảo đã sẵn sàng"),
        "vol_analysis": MessageLookupByLibrary.simpleMessage("Phân tích KL"),
        "volatility_notice":
            MessageLookupByLibrary.simpleMessage("Thông báo biến động"),
        "volatility_notice_quote1": MessageLookupByLibrary.simpleMessage(
            "Cài đặt thống báo biến động tài khoản và danh mục quan tâm của bạn"),
        "volatility_warning":
            MessageLookupByLibrary.simpleMessage("Cảnh báo biến động"),
        "volumn": MessageLookupByLibrary.simpleMessage("Khối lượng"),
        "wrong_password":
            MessageLookupByLibrary.simpleMessage("Mật khẩu không chính xác"),
        "you_are_not_account":
            MessageLookupByLibrary.simpleMessage("Bạn chưa có tài khoản?"),
        "you_are_not_logged_in":
            MessageLookupByLibrary.simpleMessage("Bạn chưa đăng nhập")
      };
}
