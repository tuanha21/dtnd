class Head {
  num? iD;
  num? companyID;
  num? yearPeriod;
  String? termCode;
  String? termName;
  String? termNameEN;
  num? reportTermID;
  num? displayOrdering;
  String? united;
  String? auditedStatus;
  String? periodBegin;
  String? periodEnd;
  num? totalRow;
  num? businessType;

  Head(
      {this.iD,
        this.companyID,
        this.yearPeriod,
        this.termCode,
        this.termName,
        this.termNameEN,
        this.reportTermID,
        this.displayOrdering,
        this.united,
        this.auditedStatus,
        this.periodBegin,
        this.periodEnd,
        this.totalRow,
        this.businessType});

  Head.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyID = json['CompanyID'];
    yearPeriod = json['YearPeriod'];
    termCode = json['TermCode'];
    termName = json['TermName'];
    termNameEN = json['TermNameEN'];
    reportTermID = json['ReportTermID'];
    displayOrdering = json['DisplayOrdering'];
    united = json['United'];
    auditedStatus = json['AuditedStatus'];
    periodBegin = json['PeriodBegin'];
    periodEnd = json['PeriodEnd'];
    totalRow = json['TotalRow'];
    businessType = json['BusinessType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CompanyID'] = companyID;
    data['YearPeriod'] = yearPeriod;
    data['TermCode'] = termCode;
    data['TermName'] = termName;
    data['TermNameEN'] = termNameEN;
    data['ReportTermID'] = reportTermID;
    data['DisplayOrdering'] = displayOrdering;
    data['United'] = united;
    data['AuditedStatus'] = auditedStatus;
    data['PeriodBegin'] = periodBegin;
    data['PeriodEnd'] = periodEnd;
    data['TotalRow'] = totalRow;
    data['BusinessType'] = businessType;
    return data;
  }
}
