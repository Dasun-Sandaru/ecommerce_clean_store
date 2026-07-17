class Product {
  final String id;
  final String name;
  final double price;
  int _stockQuantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required int stockQuantity,
  }) : _stockQuantity = stockQuantity;

  int get stockQuantity => _stockQuantity;

  set reduceStock(int quantity) {
    if (quantity < 0) {
      throw Exception('Stock quantity cannot be negative.');
    }
    _stockQuantity -= quantity;
  }
}
