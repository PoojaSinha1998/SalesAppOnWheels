class registerMobile {
  String message;
  List<Result> result;

  registerMobile({this.message, this.result});

  registerMobile.fromJson(Map<String, dynamic> json) {
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
  String status;
  String createdAt;
  String verificationToken;
  String description;

  Result(
      {this.id,
        this.loogedinid,
        this.phone,
        this.status,
        this.createdAt,
        this.verificationToken,
      this.description});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loogedinid = json['loogedinid'];
    phone = json['phone'];
    status = json['status'];
    createdAt = json['created_at'];
    verificationToken = json['verification_token'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loogedinid'] = this.loogedinid;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['verification_token'] = this.verificationToken;
    data['description'] = this.description;
    return data;
  }
}