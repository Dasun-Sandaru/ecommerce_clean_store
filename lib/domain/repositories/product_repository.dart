import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
  Future<void> updatedProductStock(String productId, int quantity);
}
