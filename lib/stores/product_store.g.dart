// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductStore on _ProductStore, Store {
  late final _$productsAtom =
      Atom(name: '_ProductStore.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$loadProductsAsyncAction =
      AsyncAction('_ProductStore.loadProducts', context: context);

  @override
  Future<void> loadProducts() {
    return _$loadProductsAsyncAction.run(() => super.loadProducts());
  }

  late final _$addProductAsyncAction =
      AsyncAction('_ProductStore.addProduct', context: context);

  @override
  Future<void> addProduct(Product product) {
    return _$addProductAsyncAction.run(() => super.addProduct(product));
  }

  late final _$updateProductAsyncAction =
      AsyncAction('_ProductStore.updateProduct', context: context);

  @override
  Future<void> updateProduct(int index, Product product) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(index, product));
  }

  late final _$deleteProductAsyncAction =
      AsyncAction('_ProductStore.deleteProduct', context: context);

  @override
  Future<void> deleteProduct(int index) {
    return _$deleteProductAsyncAction.run(() => super.deleteProduct(index));
  }

  late final _$toggleDiscountStatusAsyncAction =
      AsyncAction('_ProductStore.toggleDiscountStatus', context: context);

  @override
  Future<void> toggleDiscountStatus(int index) {
    return _$toggleDiscountStatusAsyncAction
        .run(() => super.toggleDiscountStatus(index));
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
