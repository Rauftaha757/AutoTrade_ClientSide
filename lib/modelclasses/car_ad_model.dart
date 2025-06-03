class CarAd_model {
  final List<String> imageurl;
  final String transmition;
  final int milage;
  final int model;
  final String registration;
  final String carname;
  final String company;
  final int enginecapacity;
  final String city;
  final String color;
  final String assembly;
  final DateTime createdAt;
  final String contact;
  final String price;
  CarAd_model({
    required this.imageurl,
    required this.transmition,
    required this.milage,
    required this.model,
    required this.registration,
    required this.carname,
    required this.company,
    required this.enginecapacity,
    required this.city,
    required this.color,
    required this.assembly,
    required this.createdAt,
    required this.contact,
    required this.price,
  });

  factory CarAd_model.fromjson(Map<String, dynamic> json) {
    return CarAd_model(
      imageurl: (json['imageurl'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      price:json['price'] ?? " ",
      transmition: json['transmition'] ?? '',
      milage: json['milage'] ?? 0,
      model: json['model'] ?? 0,
      registration: json['registration'] ?? '',
      carname: json['carname'] ?? '',
      company: json['company'] ?? '',
      enginecapacity: json['enginecapacity'] ?? 0,
      city: json['city'] ?? '',
      color: json['color'] ?? '',
      assembly: json['assembly'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      contact: json['contact'] ?? '',
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'imageurl': imageurl,
      'transmition': transmition,
      'milage': milage,
      'model': model,
      'registration': registration,
      'carname': carname,
      'company': company,
      'enginecapacity': enginecapacity,
      'city': city,
      'color': color,
      'assembly': assembly,
      'createdAt': createdAt.toIso8601String(),
      'contact': contact,
      "price":price,
    };
  }
}
