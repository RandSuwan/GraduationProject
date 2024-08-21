class ShippingInfo {
  final String name;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String phoneNumber;

  ShippingInfo({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phoneNumber,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      name: json['name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      phoneNumber: json['phoneNumber'],
);
}
}