import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final List<Product> _mockDatabaseProducts = [];

  ProductRepositoryImpl() {
    _mockDatabaseProducts.addAll([
      Product(
        id: 'P001',
        name: 'MacBook Pro M3',
        price: 450000.0,
        stockQuantity: 5,
      ),
      Product(
        id: 'P002',
        name: 'iPhone 15 Pro',
        price: 380000.0,
        stockQuantity: 10,
      ),
      Product(
        id: 'P003',
        name: 'Sony WH-1000XM5',
        price: 950000.0,
        stockQuantity: 3,
      ),
    ]);
  }

  @override
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(Duration(milliseconds: 300));

    return List.unmodifiable(_mockDatabaseProducts);
  }

  @override
  Future<void> updatedProductStock(String productId, int quantity) async {
    await Future.delayed(Duration(milliseconds: 300));

    final productIndex = _mockDatabaseProducts.indexWhere(
      (p) => p.id == productId,
    );

    if (productIndex != -1) {
      print("[DB Update] Stock of product $productId updated to $quantity");
    } else {
      throw Exception("Product not found");
    }
  }
}
