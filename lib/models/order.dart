// class Order {
//  late int id;
//  late List<Car> cars;
//  late String? orderType;
//  late String? discountCode;
//  late String? instruction;
//  late String deliverAt;
//  late String deliveryDate;
//  late String address;
//  late String lat;
//  late String long;
//  late String status;
//  late String? reason;
//  late String? refundAt;
//  late String area;
//  late String city;
//  late Price totalPrice;
//
//
//
//   Order.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     if (json['cars'] != null) {
//       cars =  <Car>[];
//       json['cars'].forEach((v) {
//         cars.add(Car.fromJson(v));
//       });
//     }
//     orderType = json['orderType'];
//     discountCode = json['discountCode'];
//     instruction = json['instruction'];
//     deliverAt = json['deliverAt'];
//     deliveryDate = json['delivery_date'];
//     address = json['address'];
//     lat = json['lat'];
//     long = json['long'];
//     status = json['status'];
//     reason = json['reason'];
//     refundAt = json['refund_at'];
//     area = json['area'];
//     city = json['city'];
//     totalPrice = json['total_price'];
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['id'] = this.id;
//   //   if (this.cars != null) {
//   //     data['cars'] = this.cars.map((v) => v.toJson()).toList();
//   //   }
//   //   data['orderType'] = this.orderType;
//   //   data['discountCode'] = this.discountCode;
//   //   data['instruction'] = this.instruction;
//   //   data['deliverAt'] = this.deliverAt;
//   //   data['delivery_date'] = this.deliveryDate;
//   //   data['address'] = this.address;
//   //   data['lat'] = this.lat;
//   //   data['long'] = this.long;
//   //   data['status'] = this.status;
//   //   data['reason'] = this.reason;
//   //   data['refund_at'] = this.refundAt;
//   //   data['area'] = this.area;
//   //   data['city'] = this.city;
//   //   if (this.totalPrice != null) {
//   //     data['total_price'] = this.totalPrice.toJson();
//   //   }
//   //   return data;
//   // }
// }
//
// class Car {
//  late int id;
//  late String name;
//  late String description;
//  late Price price;
//
//
//   Car.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     price = json['price'];
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['id'] = this.id;
//   //   data['name'] = this.name;
//   //   data['description'] = this.description;
//   //   if (this.price != null) {
//   //     data['price'] = this.price.toJson();
//   //   }
//   //   return data;
//   // }
// }
//
// class Price {
// late  String number;
// late  String type;
//
//
//   Price.fromJson(Map<String, dynamic> json) {
//     number = json['number'];
//     type = json['type'];
//   }
//
//   // Map<String, dynamic> toJson() {
//   //   final Map<String, dynamic> data = new Map<String, dynamic>();
//   //   data['number'] = this.number;
//   //   data['type'] = this.type;
//   //   return data;
//   // }
// }


class Order {
 late int id;
 late List<Cars> cars;
 late String? orderType;
 late String? discountCode;
 late String? instruction;
 late String deliverAt;
 late String deliveryDate;
 late String address;
 late String lat;
 late String long;
 late String status;
 late String? reason;
 late String? refundAt;
 late String area;
 late String city;
 late Price? totalPrice;



  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cars'] != null) {
      cars = <Cars>[];
      json['cars'].forEach((v) {
        cars.add(new Cars.fromJson(v));
      });
    }
    orderType = json['orderType'];
    discountCode = json['discountCode'];
    instruction = json['instruction'];
    deliverAt = json['deliverAt'];
    deliveryDate = json['delivery_date'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    status = json['status'];
    reason = json['reason'];
    refundAt = json['refund_at'];
    area = json['area'];
    city = json['city'];
    totalPrice = json['total_price'] != null
        ? new Price.fromJson(json['total_price'])
        : null;
  }


}

class Cars {
 late int id;
 late String name;
 late String description;
 late String image_url;
 late Price? price;



  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image_url = json['image_url'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
  }


}

class Price {
 late String number;
 late String type;



  Price.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    type = json['type'];
  }


}