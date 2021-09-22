class garageBranding {
  String message;
  List<ResultBrand> result;

  garageBranding({this.message, this.result});

  garageBranding.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = new List<ResultBrand>();
      json['result'].forEach((v) {
        result.add(new ResultBrand.fromJson(v));
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

class ResultBrand {
  String id;
  String title;
  String status;
  String createdAt;
  String updatedAt;

  ResultBrand({this.id, this.title, this.status, this.createdAt, this.updatedAt});

  ResultBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}