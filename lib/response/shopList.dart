
class shopList {
  String message;
  List<ResultShop> result;

  shopList({this.message, this.result});

  shopList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = new List<ResultShop>();
      json['result'].forEach((v) {
        result.add(new ResultShop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultShop {
  String id;
  String shopname;
  String ownername;
  String phone;
  String locationStatus;
  String personalStatus;
  String servicesStatus;
  String informationStatus;
  String facilityStatus;
  String photosStatus;
  String gstStatus;
  String doorNo;
  String streetName;
  String landMark;
  String locality;
  String city;
  String pincode;
  String latitude;
  String longitude;

  ResultShop(
      {this.id,
        this.shopname,
        this.ownername,
        this.phone,
        this.locationStatus,
        this.personalStatus,
        this.servicesStatus,
        this.informationStatus,
        this.facilityStatus,
        this.photosStatus,
        this.gstStatus,
        this.doorNo,
        this.streetName,
        this.landMark,
        this.locality,
        this.city,
        this.pincode,
        this.latitude,
        this.longitude});

  ResultShop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopname = json['shopname'];
    ownername = json['ownername'];
    phone = json['phone'];
    locationStatus = json['locationStatus'];
    personalStatus = json['personalStatus'];
    servicesStatus = json['servicesStatus'];
    informationStatus = json['informationStatus'];
    facilityStatus = json['facilityStatus'];
    photosStatus = json['photosStatus'];
    gstStatus = json['gstStatus'];
    doorNo = json['doorNo'];
    streetName = json['streetName'];
    landMark = json['landMark'];
    locality = json['locality'];
    city = json['city'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopname'] = this.shopname;
    data['ownername'] = this.ownername;
    data['phone'] = this.phone;
    data['locationStatus'] = this.locationStatus;
    data['personalStatus'] = this.personalStatus;
    data['servicesStatus'] = this.servicesStatus;
    data['informationStatus'] = this.informationStatus;
    data['facilityStatus'] = this.facilityStatus;
    data['photosStatus'] = this.photosStatus;
    data['gstStatus'] = this.gstStatus;
    data['doorNo'] = this.doorNo;
    data['streetName'] = this.streetName;
    data['landMark'] = this.landMark;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}