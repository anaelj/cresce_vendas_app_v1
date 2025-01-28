import 'package:cresce_vendas_app_v1/widgets/custom_app_bar.dart';
import 'package:cresce_vendas_app_v1/widgets/custom_bottom_navigation_bar.dart';
import 'package:cresce_vendas_app_v1/widgets/discount_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../models/product.dart';
import '../stores/product_store.dart';
import 'discount_detail_screen.dart';
import 'discount_form_screen.dart';

class DiscountListScreen extends StatefulWidget {
  const DiscountListScreen({super.key});

  @override
  State<DiscountListScreen> createState() => _DiscountListScreenState();
}

class _DiscountListScreenState extends State<DiscountListScreen> {
  final store = ProductStore();

  @override
  void initState() {
    super.initState();
    store.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Descontos'),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (_) => ListView.builder(
                itemCount: store.products.length,
                itemBuilder: (context, index) {
                  final product = store.products[index];
                  return discountCard(context, product, store, index);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        caption: 'Cadastrar desconto',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DiscountFormScreen(),
            ),
          ).then((_) => store.loadProducts());
        },
      ),
    );
  }
}
