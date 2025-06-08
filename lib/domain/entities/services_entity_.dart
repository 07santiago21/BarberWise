class Service {
  final String id;
  final String name;
  final double price;
  final int duration;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json['id'],
        name: json['name'],
        price: double.parse(json['price'].toString()),
        duration: json['duration'],
      );
}