class Salon {
  final String name;
  final String category;
  final String address;
  final String hours;
  final double rating;
  final List<String> services;
  final String? notes;

  const Salon({
    required this.name,
    required this.category,
    required this.address,
    required this.hours,
    required this.rating,
    required this.services,
    this.notes,
  });
}
