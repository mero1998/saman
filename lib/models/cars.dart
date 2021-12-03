//
// class Cars {
//  late int id;
//  late String name;
//  late String carNumber;
//  late String isOld;
//  late String price;
//  late String description;
//  late String address;
//  late String brandId;
//  late String modelYear;
//  late String image;
//  late String contact;
//  late String status;
//  late String addedBy;
//  late String createdAt;
//  late String updatedAt;
//  late String color;
//  late String? mileage;
//   String? engine;
//   String? fuelConsumption;
//  late String fuelType;
//  late String? fuelEconomy;
//  late String? interColor;
//  late String transmission;
//  late String? power;
//  late String drive;
//  late String? exteriorId;
//  late String? interiorImage;
//  late bool wishlist;
//  late bool inCart;
//  late String imageUrl;
//  late bool userCart;
//
//
//   Cars.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     carNumber = json['car_number'];
//     isOld = json['is_old'];
//     price = json['price'];
//     description = json['description'];
//     address = json['address'];
//     brandId = json['brand_id'];
//     modelYear = json['model_year'];
//     image = json['image'];
//     contact = json['contact'];
//     status = json['status'];
//     addedBy = json['added_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     color = json['color'];
//     mileage = json['mileage'];
//     engine = json['engine'];
//     fuelConsumption = json['fuel_consumption'];
//     fuelType = json['fuel_type'];
//     fuelEconomy = json['fuel_economy'];
//     interColor = json['inter_color'];
//     transmission = json['transmission'];
//     power = json['power'];
//     drive = json['drive'];
//     exteriorId = json['exterior_id'];
//     interiorImage = json['interior_image'];
//     wishlist = json['wishlist'];
//     inCart = json['in_cart'];
//     imageUrl = json['image_url'];
//     userCart = json['user_cart'];
//   }
//
// }
//
//

class Cars {
 late int id;
 late String name;
 late String? carNumber;
 late String? isOld;
 late String? price;
 late String? description;
 late String? address;
 late String? brandId;
 late String? modelYear;
 late String? image;
 late String? contact;
 late String? status;
 late String? addedBy;
 late String? createdAt;
 late String? updatedAt;
 late String? color;
 late String? outerColor;
 late String? mileage;
 late String? engine;
 late Null fuelConsumption;
 late String? fuelType;
 late Null fuelEconomy;
 late String? interColor;
 late Null innerColor;
 late String? transmission;
 late Null power;
 late String? drive;
 late String? exteriorId;
 late String? interiorImage;
 late String? doorsNumber;
 late String? wheelsSize;
 late String? features;
 late bool wishlist;
 late bool inCart;
 late String imageUrl;
 late bool userCart;
 late Brand? brand;


  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    carNumber = json['car_number'];
    isOld = json['is_old'];
    price = json['price'];
    description = json['description'];
    address = json['address'];
    brandId = json['brand_id'];
    modelYear = json['model_year'];
    image = json['image'];
    contact = json['contact'];
    status = json['status'];
    addedBy = json['added_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    color = json['color'];
    outerColor = json['outer_color'];
    mileage = json['mileage'];
    engine = json['engine'];
    fuelConsumption = json['fuel_consumption'];
    fuelType = json['fuel_type'];
    fuelEconomy = json['fuel_economy'];
    interColor = json['inter_color'];
    innerColor = json['inner_color'];
    transmission = json['transmission'];
    power = json['power'];
    drive = json['drive'];
    exteriorId = json['exterior_id'];
    interiorImage = json['interior_image'];
    doorsNumber = json['doors_number'];
    wheelsSize = json['wheels_size'];
    features = json['features'];
    wishlist = json['wishlist'];
    inCart = json['in_cart'];
    imageUrl = json['image_url'];
    userCart = json['user_cart'];
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
  }
}

class Brand {
 late int id;
 late String name;
 late String image;



  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
