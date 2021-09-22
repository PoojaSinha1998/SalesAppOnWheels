class FinalStatusUpdateRes {
  String message;
  List<Result> result;

  FinalStatusUpdateRes({this.message, this.result});

  FinalStatusUpdateRes.fromJson(Map<String, dynamic> json) {
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
  String uniqueID;
  String loogedinid;
  String phone;
  String shopname;
  String vehicleType;
  String status;
  String ownername;
  String secondaryphone;
  String email;
  String locationStatus;
  String personalStatus;
  String servicesStatus;
  String informationStatus;
  String facilityStatus;
  String photosStatus;
  String gstStatus;
  String finalStatus;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
        this.uniqueID,
        this.loogedinid,
        this.phone,
        this.shopname,
        this.vehicleType,
        this.status,
        this.ownername,
        this.secondaryphone,
        this.email,
        this.locationStatus,
        this.personalStatus,
        this.servicesStatus,
        this.informationStatus,
        this.facilityStatus,
        this.photosStatus,
        this.gstStatus,
        this.finalStatus,
        this.createdAt,
        this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueID = json['uniqueID'];
    loogedinid = json['loogedinid'];
    phone = json['phone'];
    shopname = json['shopname'];
    vehicleType = json['vehicleType'];
    status = json['status'];
    ownername = json['ownername'];
    secondaryphone = json['secondaryphone'];
    email = json['email'];
    locationStatus = json['locationStatus'];
    personalStatus = json['personalStatus'];
    servicesStatus = json['servicesStatus'];
    informationStatus = json['informationStatus'];
    facilityStatus = json['facilityStatus'];
    photosStatus = json['photosStatus'];
    gstStatus = json['gstStatus'];
    finalStatus = json['finalStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uniqueID'] = this.uniqueID;
    data['loogedinid'] = this.loogedinid;
    data['phone'] = this.phone;
    data['shopname'] = this.shopname;
    data['vehicleType'] = this.vehicleType;
    data['status'] = this.status;
    data['ownername'] = this.ownername;
    data['secondaryphone'] = this.secondaryphone;
    data['email'] = this.email;
    data['locationStatus'] = this.locationStatus;
    data['personalStatus'] = this.personalStatus;
    data['servicesStatus'] = this.servicesStatus;
    data['informationStatus'] = this.informationStatus;
    data['facilityStatus'] = this.facilityStatus;
    data['photosStatus'] = this.photosStatus;
    data['gstStatus'] = this.gstStatus;
    data['finalStatus'] = this.finalStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}