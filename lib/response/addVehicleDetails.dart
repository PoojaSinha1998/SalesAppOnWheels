class addVehicleDetails {
  String message;
  List<Result> result;

  addVehicleDetails({this.message, this.result});

  addVehicleDetails.fromJson(Map<String, dynamic> json) {
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
  String loogedinid;
  String phone;
  String shopname;
  String vehicleType;
  String status;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
        this.loogedinid,
        this.phone,
        this.shopname,
        this.vehicleType,
        this.status,
        this.createdAt,
        this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loogedinid = json['loogedinid'];
    phone = json['phone'];
    shopname = json['shopname'];
    vehicleType = json['vehicleType'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loogedinid'] = this.loogedinid;
    data['phone'] = this.phone;
    data['shopname'] = this.shopname;
    data['vehicleType'] = this.vehicleType;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}