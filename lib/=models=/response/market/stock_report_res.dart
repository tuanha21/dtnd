class StockReportRes {
  List<Head>? head;
  List<Content>? content;

  StockReportRes({this.head, this.content});

  StockReportRes.fromJson(Map<String, dynamic> json) {
    if (json['Head'] != null) {
      head = <Head>[];
      json['Head'].forEach((v) {
        head!.add(Head.fromJson(v));
      });
    }
    if (json['Content'] != null) {
      content = <Content>[];
      json['Content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (head != null) {
      data['Head'] = head!.map((v) => v.toJson()).toList();
    }
    if (content != null) {
      data['Content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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

class Content {
  num? iD;
  num? reportNormID;
  String? name;
  String? nameEn;
  num? parentReportNormID;
  String? reportComponentName;
  String? reportComponentNameEn;
  String? unit;
  String? unitEn;
  num? reportComponentTypeID;
  num? childTotal;
  num? levels;
  num? value1;
  num? value2;
  num? value3;
  num? value4;

  Content(
      {this.iD,
        this.reportNormID,
        this.name,
        this.nameEn,
        this.parentReportNormID,
        this.reportComponentName,
        this.reportComponentNameEn,
        this.unit,
        this.unitEn,
        this.reportComponentTypeID,
        this.childTotal,
        this.levels,
        this.value1,
        this.value2,
        this.value3,
        this.value4});

  Content.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    reportNormID = json['ReportNormID'];
    name = json['Name'];
    nameEn = json['NameEn'];
    parentReportNormID = json['ParentReportNormID'];
    reportComponentName = json['ReportComponentName'];
    reportComponentNameEn = json['ReportComponentNameEn'];
    unit = json['Unit'];
    unitEn = json['UnitEn'];
    reportComponentTypeID = json['ReportComponentTypeID'];
    childTotal = json['ChildTotal'];
    levels = json['Levels'];
    value1 = json['Value1'];
    value2 = json['Value2'];
    value3 = json['Value3'];
    value4 = json['Value4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['ReportNormID'] = reportNormID;
    data['Name'] = name;
    data['NameEn'] = nameEn;
    data['ParentReportNormID'] = parentReportNormID;
    data['ReportComponentName'] = reportComponentName;
    data['ReportComponentNameEn'] = reportComponentNameEn;
    data['Unit'] = unit;
    data['UnitEn'] = unitEn;
    data['ReportComponentTypeID'] = reportComponentTypeID;
    data['ChildTotal'] = childTotal;
    data['Levels'] = levels;
    data['Value1'] = value1;
    data['Value2'] = value2;
    data['Value3'] = value3;
    data['Value4'] = value4;
    return data;
  }
}
