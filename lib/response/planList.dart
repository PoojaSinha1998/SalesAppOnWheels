class planList {
  String message;
  List<ResultPlan> result;

  planList({this.message, this.result});

  planList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['result'] != null) {
      result = new List<ResultPlan>();
      json['result'].forEach((v) {
        result.add(new ResultPlan.fromJson(v));
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

class ResultPlan {
  String id;
  String credits;
  String price;
  String tax;
  String totalprice;

  ResultPlan({this.id, this.credits, this.price, this.tax, this.totalprice});

  ResultPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    credits = json['credits'];
    price = json['price'];
    tax = json['tax'];
    totalprice = json['totalprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['credits'] = this.credits;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['totalprice'] = this.totalprice;
    return data;
  }
}