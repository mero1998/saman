class Address {
late  int id;
late  String title;
late  String? lat;
late  String? long;
late  String? address;
late  String pincode;
late  String? street;
late  String appartment;
late  String city;
late  String area;


  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
    pincode = json['pincode'];
    street = json['street'];
    appartment = json['appartment'];
    city = json['city'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['street'] = this.street;
    data['appartment'] = this.appartment;
    data['city'] = this.city;
    data['area'] = this.area;
    return data;
  }
}