class PageSetting {
 late int id;
 late String title;
 late String description;
 late String image;
 late String order;
 late String createdAt;


  PageSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    order = json['order'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['order'] = this.order;
    data['created_at'] = this.createdAt;
    return data;
  }
}