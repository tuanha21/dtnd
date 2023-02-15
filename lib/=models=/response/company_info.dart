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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyCode'] = companyCode;
    data['CompanyType'] = companyType;
    data['Name'] = name;
    data['FullName'] = fullName;
    data['FullNameEn'] = fullNameEn;
    data['Image'] = image;
    data['TaxCode'] = taxCode;
    data['Address'] = address;
    data['Phone'] = phone;
    data['Fax'] = fax;
    data['Email'] = email;
    data['URL'] = uRL;
    data['Status'] = status;
    data['FoundPermit'] = foundPermit;
    data['FoundDate'] = foundDate;
    data['BusinessPermit'] = businessPermit;
    data['IssueDate'] = issueDate;
    data['ContactPerson'] = contactPerson;
    data['ContactPersonPosition'] = contactPersonPosition;
    data['IdentityNumber'] = identityNumber;
    data['PermanentAddress'] = permanentAddress;
    data['InfoSupplier'] = infoSupplier;
    data['InfoSupplierPosition'] = infoSupplierPosition;
    data['PhoneSupplier'] = phoneSupplier;
    data['Introduction'] = introduction;
    data['Capital'] = capital;
    data['Notes'] = notes;
    data['OtherInfo'] = otherInfo;
    data['PostUpDate'] = postUpDate;
    data['StockFaceValue'] = stockFaceValue;
    data['Branch'] = branch;
    data['CtyKiemToan'] = ctyKiemToan;
    data['LastUpdate'] = lastUpdate;
    data['FirstTradingSessionPrice'] = firstTradingSessionPrice;
    data['IsMargin'] = isMargin;
    data['IsFTSE'] = isFTSE;
    data['IsVNMETF'] = isVNMETF;
    data['IsVN30'] = isVN30;
    data['IsHNX30'] = isHNX30;
    data['IndustryName'] = industryName;
    data['SubIndustryName'] = subIndustryName;
    data['SectorName'] = sectorName;
    data['CompanyTypeName'] = companyTypeName;
    data['Exchange'] = exchange;
    return data;
  }
}
