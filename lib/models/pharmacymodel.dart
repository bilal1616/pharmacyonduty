class Model {
  String? name;
  String? dist;
  String? address;
  String? phone;
  String? loc;

  Model({this.name, this.dist, this.address, this.phone, this.loc});

  Model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dist = json['dist'];
    address = json['address'];
    phone = json['phone'];
    loc = json['loc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['dist'] = dist;
    data['address'] = address;
    data['phone'] = phone;
    data['loc'] = loc;
    return data;
  }

  @override
  String toString() {
    return "Name:$name \n Address:$address \n Phone:$phone";
  }
}
