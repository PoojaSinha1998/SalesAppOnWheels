import 'dart:io';

class RechargeSaveModel {
  String city;
  String vehicleType;
  String shopName;
  String receiptNumber;
  String name;
  String number;
  String address;
  String revenueMonth;
  String paymentMethod;
  String upiid;
  String receiptNo;
  List<File> receiptImage;
  List<File> paymentImage;

  RechargeSaveModel(
      {this.city,
      this.vehicleType,
      this.shopName,
      this.receiptNumber,
      this.name,
      this.number,
      this.address,
      this.revenueMonth,
      this.paymentMethod,
      this.upiid,
      this.receiptNo,
      this.receiptImage,
      this.paymentImage});

  RechargeSaveModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    vehicleType = json['vehicleType'];
    shopName = json['shopName'];
    receiptNumber = json['receiptNumber'];
    name = json['name'];
    number = json['number'];
    address = json['address'];
    revenueMonth = json['revenueMonth'];
    paymentMethod = json['paymentMethod'];
    upiid = json['upiid'];
    receiptNo = json['receiptNo'];
    receiptImage = json['receiptImage'].cast<File>();
    paymentImage = json['paymentImage'].cast<File>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['vehicleType'] = this.vehicleType;
    data['shopName'] = this.shopName;
    data['receiptNumber'] = this.receiptNumber;
    data['name'] = this.name;
    data['number'] = this.number;
    data['address'] = this.address;
    data['revenueMonth'] = this.revenueMonth;
    data['paymentMethod'] = this.paymentMethod;
    data['upiid'] = this.upiid;
    data['receiptNo'] = this.receiptNo;
    data['receiptImage'] = this.receiptImage;
    data['paymentImage'] = this.paymentImage;
    return data;
  }
}