class addGarageInformation {
  String message;
  List<Result> result;

  addGarageInformation({this.message, this.result});

  addGarageInformation.fromJson(Map<String, dynamic> json) {
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
  String establishyear;
  String areasqft;
  String noofmechanics;
  String workingdays;
  String workingfromtime;
  String workingtotime;
  String garagaebrandid;
  String banknameid;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
        this.userid,
        this.establishyear,
        this.areasqft,
        this.noofmechanics,
        this.workingdays,
        this.workingfromtime,
        this.workingtotime,
        this.garagaebrandid,
        this.banknameid,
        this.createdAt,
        this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    establishyear = json['establishyear'];
    areasqft = json['areasqft'];
    noofmechanics = json['noofmechanics'];
    workingdays = json['workingdays'];
    workingfromtime = json['workingfromtime'];
    workingtotime = json['workingtotime'];
    garagaebrandid = json['garagaebrandid'];
    banknameid = json['banknameid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['establishyear'] = this.establishyear;
    data['areasqft'] = this.areasqft;
    data['noofmechanics'] = this.noofmechanics;
    data['workingdays'] = this.workingdays;
    data['workingfromtime'] = this.workingfromtime;
    data['workingtotime'] = this.workingtotime;
    data['garagaebrandid'] = this.garagaebrandid;
    data['banknameid'] = this.banknameid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}