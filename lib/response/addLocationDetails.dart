class addLocationDetails {
  String message;
  List<Result> result;

  addLocationDetails({this.message, this.result});

  addLocationDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
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

class Result {
  String id;
  String userid;
  String doorNo;
  String streetName;
  String landMark;
  String locality;
  String city;
  String pincode;
  String latitude;
  String longitude;
  String createdAt;
  Null updatedAt;

  Result(
      {this.id,
        this.userid,
        this.doorNo,
        this.streetName,
        this.landMark,
        this.locality,
        this.city,
        this.pincode,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    doorNo = json['doorNo'];
    streetName = json['streetName'];
    landMark = json['landMark'];
    locality = json['locality'];
    city = json['city'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['doorNo'] = this.doorNo;
    data['streetName'] = this.streetName;
    data['landMark'] = this.landMark;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}