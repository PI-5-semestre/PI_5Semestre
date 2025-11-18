class Delivery {
  String? name;
  String? status;
  String? phone;
  String? address;
  String? observations;

  Delivery({
    required this.name,
    required this.status,
    required this.phone,
    required this.address,
    this.observations = "",
  });
}
