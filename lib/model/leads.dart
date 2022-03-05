class Leads {
  Leads({
    this.address,
    this.id,
    this.phoneNumber,
    this.fullName,
    this.email,
  });

  Leads.fromJson(dynamic json) {
    address = json['address'];
    id = json['id'];
    phoneNumber = json['phone number'];
    fullName = json['full name'];
    email = json['email'];
  }
  String? address;
  String? id;
  String? phoneNumber;
  String? fullName;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['id'] = id;
    map['phone number'] = phoneNumber;
    map['full name'] = fullName;
    map['email'] = email;
    return map;
  }
}
