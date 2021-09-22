class LoginRes {
  String message;
  List<Result> result;

  LoginRes({this.message, this.result});

  LoginRes.fromJson(Map<String, dynamic> json) {
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
  String name;
  String email;
  String phone;
  String gender;
  String createdAt;
  String description;

  Result(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.gender,
        this.createdAt,
      this.description});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    createdAt = json['created_at'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    return data;
  }
}