class CompanyInfo {
  String? companyCode;
  int? companyType;
  String? name;
  String? fullName;
  String? fullNameEn;
  String? image;
  String? taxCode;
  String? address;
  String? phone;
  String? fax;
  String? email;
  String? uRL;
  int? status;
  String? foundPermit;
  String? foundDate;
  String? businessPermit;
  String? issueDate;
  String? contactPerson;
  String? contactPersonPosition;
  String? identityNumber;
  String? permanentAddress;
  String? infoSupplier;
  String? infoSupplierPosition;
  String? phoneSupplier;
  String? introduction;
  int? capital;
  String? notes;
  String? otherInfo;
  String? postUpDate;
  int? stockFaceValue;
  String? branch;
  String? ctyKiemToan;
  String? lastUpdate;
  int? firstTradingSessionPrice;
  bool? isMargin;
  bool? isFTSE;
  bool? isVNMETF;
  bool? isVN30;
  bool? isHNX30;
  String? industryName;
  String? subIndustryName;
  String? sectorName;
  String? companyTypeName;
  String? exchange;

  CompanyInfo(
      {this.companyCode,
        this.companyType,
        this.name,
        this.fullName,
        this.fullNameEn,
        this.image,
        this.taxCode,
        this.address,
        this.phone,
        this.fax,
        this.email,
        this.uRL,
        this.status,
        this.foundPermit,
        this.foundDate,
        this.businessPermit,
        this.issueDate,
        this.contactPerson,
        this.contactPersonPosition,
        this.identityNumber,
        this.permanentAddress,
        this.infoSupplier,
        this.infoSupplierPosition,
        this.phoneSupplier,
        this.introduction,
        this.capital,
        this.notes,
        this.otherInfo,
        this.postUpDate,
        this.stockFaceValue,
        this.branch,
        this.ctyKiemToan,
        this.lastUpdate,
        this.firstTradingSessionPrice,
        this.isMargin,
        this.isFTSE,
        this.isVNMETF,
        this.isVN30,
        this.isHNX30,
        this.industryName,
        this.subIndustryName,
        this.sectorName,
        this.companyTypeName,
        this.exchange});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    companyType = json['CompanyType'];
    name = json['Name'];
    fullName = json['FullName'];
    fullNameEn = json['FullNameEn'];
    image = json['Image'];
    taxCode = json['TaxCode'];
    address = json['Address'];
    phone = json['Phone'];
    fax = json['Fax'];
    email = json['Email'];
    uRL = json['URL'];
    status = json['Status'];
    foundPermit = json['FoundPermit'];
    foundDate = json['FoundDate'];
    businessPermit = json['BusinessPermit'];
    issueDate = json['IssueDate'];
    contactPerson = json['ContactPerson'];
    contactPersonPosition = json['ContactPersonPosition'];
    identityNumber = json['IdentityNumber'];
    permanentAddress = json['PermanentAddress'];
    infoSupplier = json['InfoSupplier'];
    infoSupplierPosition = json['InfoSupplierPosition'];
    phoneSupplier = json['PhoneSupplier'];
    introduction = json['Introduction'];
    capital = json['Capital'];
    notes = json['Notes'];
    otherInfo = json['OtherInfo'];
    postUpDate = json['PostUpDate'];
    stockFaceValue = json['StockFaceValue'];
    branch = json['Branch'];
    ctyKiemToan = json['CtyKiemToan'];
    lastUpdate = json['LastUpdate'];
    firstTradingSessionPrice = json['FirstTradingSessionPrice'];
    isMargin = json['IsMargin'];
    isFTSE = json['IsFTSE'];
    isVNMETF = json['IsVNMETF'];
    isVN30 = json['IsVN30'];
    isHNX30 = json['IsHNX30'];
    industryName = json['IndustryName'];
    subIndustryName = json['SubIndustryName'];
    sectorName = json['SectorName'];
    companyTypeName = json['CompanyTypeName'];
    exchange = json['Exchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['CompanyType'] = this.companyType;
    data['Name'] = this.name;
    data['FullName'] = this.fullName;
    data['FullNameEn'] = this.fullNameEn;
    data['Image'] = this.image;
    data['TaxCode'] = this.taxCode;
    data['Address'] = this.address;
    data['Phone'] = this.phone;
    data['Fax'] = this.fax;
    data['Email'] = this.email;
    data['URL'] = this.uRL;
    data['Status'] = this.status;
    data['FoundPermit'] = this.foundPermit;
    data['FoundDate'] = this.foundDate;
    data['BusinessPermit'] = this.businessPermit;
    data['IssueDate'] = this.issueDate;
    data['ContactPerson'] = this.contactPerson;
    data['ContactPersonPosition'] = this.contactPersonPosition;
    data['IdentityNumber'] = this.identityNumber;
    data['PermanentAddress'] = this.permanentAddress;
    data['InfoSupplier'] = this.infoSupplier;
    data['InfoSupplierPosition'] = this.infoSupplierPosition;
    data['PhoneSupplier'] = this.phoneSupplier;
    data['Introduction'] = this.introduction;
    data['Capital'] = this.capital;
    data['Notes'] = this.notes;
    data['OtherInfo'] = this.otherInfo;
    data['PostUpDate'] = this.postUpDate;
    data['StockFaceValue'] = this.stockFaceValue;
    data['Branch'] = this.branch;
    data['CtyKiemToan'] = this.ctyKiemToan;
    data['LastUpdate'] = this.lastUpdate;
    data['FirstTradingSessionPrice'] = this.firstTradingSessionPrice;
    data['IsMargin'] = this.isMargin;
    data['IsFTSE'] = this.isFTSE;
    data['IsVNMETF'] = this.isVNMETF;
    data['IsVN30'] = this.isVN30;
    data['IsHNX30'] = this.isHNX30;
    data['IndustryName'] = this.industryName;
    data['SubIndustryName'] = this.subIndustryName;
    data['SectorName'] = this.sectorName;
    data['CompanyTypeName'] = this.companyTypeName;
    data['Exchange'] = this.exchange;
    return data;
  }
}
