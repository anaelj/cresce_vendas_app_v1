import 'package:mobx/mobx.dart';
import 'package:hive/hive.dart';
import '../models/product.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStore with _$ProductStore;

abstract class _ProductStore with Store {
  final Box<Product> _box = Hive.box<Product>('products');

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @action
  Future<void> loadProducts() async {
    products = ObservableList.of(_box.values.toList());
  }

  @action
  Future<void> addProduct(Product product) async {
    await _box.add(product);
    await loadProducts();
  }

  @action
  Future<void> updateProduct(int index, Product product) async {
    await _box.putAt(index, product);
    await loadProducts();
  }

  @action
  Future<void> deleteProduct(int index) async {
    var keyAtIndex = _box.keyAt(index);
    await _box.delete(keyAtIndex);
    // await loadProducts();
  }

  @action
  Future<void> toggleDiscountStatus(int index) async {
    final product = products[index];
    if (product.discount != null) {
      product.discount!.status = !product.discount!.status;
      await updateProduct(index, product);
    }
  }
}
