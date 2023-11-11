import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/gender.dart';

class UserInfo implements CoreResponseModel {
  late final String? pkCustCustomer;
  late final String? branchCode;
  late final String? subBranchCode;
  late final String? marketingId;
  late final String? mktName;
  late final String? customerCode;
  late final String? customerName;
  late final String? cardIdType;
  late final String? cardId;
  late final String? idIssueDate;
  late final String? idExpireDate;
  late final String? idIssuePlace;
  late final String? customerType;
  late final String? taxCode;
  late final String? nationalCode;
  late final String? custFullName;
  late final Gender? custGender;
  late final String? custBirthday;
  late final String? custBirthPlace;
  late final num? custLiveInVietnam;
  late final String? custEmail;
  late final String? custMobile;
  late final String? custTel;
  late final String? contactAddress;
  late final String? custResedenceAddress;
  late final String? province;
  late final String? authenSign;
  late final String? frontCard;
  late final String? backCard;
  late final String? signImg;
  late final String? faceImg;
  late final num? internetFlag;
  late final num? phoneFlag;
  late final num? marginFlag;

  dynamic parse(dynamic data) {
    if (data is String && (data.toLowerCase() == "null" || data == "")) {
      return null;
    } else {
      return data;
    }
  }

  UserInfo.fromJson(Map<String, dynamic> json) {
    pkCustCustomer = parse(json['PK_CUST_CUSTOMER']);
    branchCode = parse(json['C_BRANCH_CODE']);
    subBranchCode = parse(json['C_SUB_BRANCH_CODE']);
    marketingId = parse(json['C_MARKETING_ID']);
    mktName = parse(json['C_MKT_NAME']);
    customerCode = parse(json['C_CUSTOMER_CODE']);
    customerName = parse(json['C_CUSTOMER_NAME']);
    cardIdType = parse(json['C_CARD_ID_TYPE']);
    cardId = parse(json['C_CARD_ID']);
    idIssueDate = parse(json['C_ID_ISSUE_DATE']);
    idExpireDate = parse(json['C_ID_EXPIRE_DATE']);
    idIssuePlace = parse(json['C_ID_ISSUE_PLACE']);
    customerType = parse(json['C_CUSTOMER_TYPE']);
    taxCode = parse(json['C_TAX_CODE']);
    nationalCode = parse(json['C_NATIONAL_CODE']);
    custFullName = parse(json['C_CUST_FULL_NAME']);
    custGender = GenderHelper.fromCode(json['C_CUST_GENDER']);
    custBirthday = parse(json['C_CUST_BIRTH_DAY']);
    custBirthPlace = parse(json['C_CUST_BIRTH_PLACE']);
    custLiveInVietnam = parse(json['C_CUST_LIVE_IN_VIETNAM']);
    custEmail = parse(json['C_CUST_EMAIL']);
    custMobile = parse(json['C_CUST_MOBILE']);
    custTel = parse(json['C_CUST_TEL']);
    contactAddress = parse(json['C_CONTACT_ADDRESS']);
    custResedenceAddress = parse(json['C_CUST_RESEDENCE_ADDRESS']);
    province = parse(json['C_PROVINCE']);
    authenSign = parse(json['C_AUTHEN_SIGN']);
    frontCard = parse(json['C_FRONT_CARD']);
    backCard = parse(json['C_BACK_CARD']);
    signImg = parse(json['C_SIGN_IMG']);
    faceImg = parse(json['C_FACE_IMG']);
    internetFlag = parse(json['C_INTERNET_FLAG']);
    phoneFlag = parse(json['C_PHONE_FLAG']);
    marginFlag = parse(json['C_MARGIN_FLAG']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PK_CUST_CUSTOMER'] = pkCustCustomer;
    data['C_BRANCH_CODE'] = branchCode;
    data['C_SUB_BRANCH_CODE'] = subBranchCode;
    data['C_MARKETING_ID'] = marketingId;
    data['C_MKT_NAME'] = mktName;
    data['C_CUSTOMER_CODE'] = customerCode;
    data['C_CUSTOMER_NAME'] = customerName;
    data['C_CARD_ID_TYPE'] = cardIdType;
    data['C_CARD_ID'] = cardId;
    data['C_ID_ISSUE_DATE'] = idIssueDate;
    data['C_ID_EXPIRE_DATE'] = idExpireDate;
    data['C_ID_ISSUE_PLACE'] = idIssuePlace;
    data['C_CUSTOMER_TYPE'] = customerType;
    data['C_TAX_CODE'] = taxCode;
    data['C_NATIONAL_CODE'] = nationalCode;
    data['C_CUST_FULL_NAME'] = custFullName;
    data['C_CUST_GENDER'] = custGender;
    data['C_CUST_BIRTH_DAY'] = custBirthday;
    data['C_CUST_BIRTH_PLACE'] = custBirthPlace;
    data['C_CUST_LIVE_IN_VIETNAM'] = custLiveInVietnam;
    data['C_CUST_EMAIL'] = custEmail;
    data['C_CUST_MOBILE'] = custMobile;
    data['C_CUST_TEL'] = custTel;
    data['C_CONTACT_ADDRESS'] = contactAddress;
    data['C_CUST_RESEDENCE_ADDRESS'] = custResedenceAddress;
    data['C_PROVINCE'] = province;
    data['C_AUTHEN_SIGN'] = authenSign;
    data['C_FRONT_CARD'] = frontCard;
    data['C_BACK_CARD'] = backCard;
    data['C_SIGN_IMG'] = signImg;
    data['C_FACE_IMG'] = faceImg;
    data['C_INTERNET_FLAG'] = internetFlag;
    data['C_PHONE_FLAG'] = phoneFlag;
    data['C_MARGIN_FLAG'] = marginFlag;
    return data;
  }
}
