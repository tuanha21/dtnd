import 'package:dtnd/utilities/regex.dart';
import 'package:dtnd/utilities/string_util.dart';

import '../l10n/generated/l10n.dart';

mixin AppValidator {
  // static final RegExp _emailRegex =
  //     RegExp(r'^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$');
  static final RegExp _phoneNumberRegex =
      RegExp(r'^(\+)?(\d{1,3})?([-.\s]?\d{2,4}[-.\s]?){2,5}\d{2,4}$');

  String? pinValidator(String? pin) {
    // TODO : uncomment
    // if (pin?.isEmpty ?? true) {
    //   return "Không được bỏ trống";
    // }
    // if (pin!.length < 6) {
    //   return "Pin quá ngắn";
    // }
    return null;
  }

  String? phoneNumberValidator(String? phone) {
    if (phone?.isEmpty ?? true) {
      return "Không được bỏ trống";
    }
    if (!_phoneNumberRegex.hasMatch(phone!)) {
      return "Số điện thoại sai định dạng";
    }
    return null;
  }

  String? catalogNameValidator(String? name) {
    if (name?.isEmpty ?? true) {
      return "Không được bỏ trống";
    }
    return null;
  }

  String? checkAccountShort(String? account) {
    if (account?.isEmpty ?? true) {
      return "Không được bỏ trống";
    }
    if (account!.length < 6) {
      return "Ít nhất 6 ký tự";
    }
    return null;
  }

  String? checkAccountNotMatchSpecial(String? account) {
    if (account?.isEmpty ?? true) {
      return "Không được bỏ trống";
    }
    if (!specialCharacters.hasMatch(account!)) {
      return "Tài khoản chứa ký tự đặc biệt";
    }
    return null;
  }

  String? checkFullName(String? name) {
    if (name?.isEmpty ?? true) {
      return "Không được bỏ trống";
    }
    if (name!.length < 4) {
      return "Họ và tên cần tối thiếu 4 ký tự";
    }
    return null;
  }

  String? checkEmail(String? email) {
    if (email?.isEmpty ?? true) {
      return "Không được bỏ trống";
    }
    if (!emailRegex.hasMatch(email!)) {
      return "Sai định dạng email. Vui lòng thử lại";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if ((value?.length ?? 0) < 8) {
      return S.current.null_password;
    }
    return null;
  }

  String? checkConfirmPass(String? rePass, String? pass) {
    if (rePass?.isEmpty ?? true) {
      return S.current.please_input_password;
    } else if (rePass != pass) {
      return S.current.pass_not_match;
    } else {
      return null;
    }
  }

  String? checkConfirmRePass(String? rePass, String? pass) {
    if (rePass?.isEmpty ?? true) {
      return "Nhập lại mật khẩu";
    } else if (rePass != pass) {
      return S.current.pass_not_match;
    } else {
      return null;
    }
  }

  String? volumnValidator(String? vol) {
    if (vol?.isEmpty ?? true) {
      return "Khối lượng không được bỏ trống";
    } else if (!vol!.isNum) {
      return "Khối lượng phải là số lớn hơn 0";
    } else {
      return null;
    }
  }
}
