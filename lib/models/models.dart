class ModelsCars {
 late String modelYear;

  ModelsCars.fromJson(Map<String, dynamic> json) {
    modelYear = json['model_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_year'] = this.modelYear;
    return data;
  }
}