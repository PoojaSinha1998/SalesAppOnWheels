class addServicelDetails {
  String message;
  List<Result> result;

  addServicelDetails({this.message, this.result});

  addServicelDetails.fromJson(Map<String, dynamic> json) {
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
  String title;
  String fimage;
  String price;
  String offerPrice;
  String description;
  String serviceType;
  String pickup;
  String doorstep;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
        this.title,
        this.fimage,
        this.price,
        this.offerPrice,
        this.description,
        this.serviceType,
        this.pickup,
        this.doorstep,
        this.createdAt,
        this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fimage = json['fimage'];
    price = json['price'];
    offerPrice = json['offer_price'];
    description = json['description'];
    serviceType = json['service_type'];
    pickup = json['pickup'];
    doorstep = json['doorstep'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['fimage'] = this.fimage;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    data['description'] = this.description;
    data['service_type'] = this.serviceType;
    data['pickup'] = this.pickup;
    data['doorstep'] = this.doorstep;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}