class addGarageFacilityInformation {
  String message;
  List<Result> result;

  addGarageFacilityInformation({this.message, this.result});

  addGarageFacilityInformation.fromJson(Map<String, dynamic> json) {
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
  String peakCapacity;
  String workBoys;
  String ramps;
  String paintBooths;
  String fulltime;
  String washfacility;
  String dentPullerMachine;
  String wheelAlignmentFacility;
  String onlinePayment;
  String neftImps;
  String cardSwipeMachine;
  String creditCardPayments;
  String createdAt;
  String updatedAt;

  Result(
      {this.id,
        this.userid,
        this.peakCapacity,
        this.workBoys,
        this.ramps,
        this.paintBooths,
        this.fulltime,
        this.washfacility,
        this.dentPullerMachine,
        this.wheelAlignmentFacility,
        this.onlinePayment,
        this.neftImps,
        this.cardSwipeMachine,
        this.creditCardPayments,
        this.createdAt,
        this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    peakCapacity = json['peakCapacity'];
    workBoys = json['workBoys'];
    ramps = json['ramps'];
    paintBooths = json['paintBooths'];
    fulltime = json['fulltime'];
    washfacility = json['washfacility'];
    dentPullerMachine = json['dentPullerMachine'];
    wheelAlignmentFacility = json['wheelAlignmentFacility'];
    onlinePayment = json['onlinePayment'];
    neftImps = json['neftImps'];
    cardSwipeMachine = json['cardSwipeMachine'];
    creditCardPayments = json['creditCardPayments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['peakCapacity'] = this.peakCapacity;
    data['workBoys'] = this.workBoys;
    data['ramps'] = this.ramps;
    data['paintBooths'] = this.paintBooths;
    data['fulltime'] = this.fulltime;
    data['washfacility'] = this.washfacility;
    data['dentPullerMachine'] = this.dentPullerMachine;
    data['wheelAlignmentFacility'] = this.wheelAlignmentFacility;
    data['onlinePayment'] = this.onlinePayment;
    data['neftImps'] = this.neftImps;
    data['cardSwipeMachine'] = this.cardSwipeMachine;
    data['creditCardPayments'] = this.creditCardPayments;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}