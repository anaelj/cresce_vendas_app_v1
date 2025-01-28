import 'package:cresce_vendas_app_v1/utils/currency.dart';
import 'package:cresce_vendas_app_v1/widgets/custom_app_bar.dart';
import 'package:cresce_vendas_app_v1/components/custom_switch_tile.dart';
import 'package:cresce_vendas_app_v1/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'discount_form_screen.dart';
import '../stores/product_store.dart';
import 'dart:io';

class DiscountDetailScreen extends StatefulWidget {
  final Product product;
  final ProductStore store;
  final int index;

  const DiscountDetailScreen({
    super.key,
    required this.product,
    required this.store,
    required this.index,
  });

  @override
  State<DiscountDetailScreen> createState() => _DiscountDetailScreenState();
}

class _DiscountDetailScreenState extends State<DiscountDetailScreen> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _switchValue = widget.product.discount?.status ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Detalhe do desconto'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            CustomSwitch(
              value: _switchValue,
              onChanged: (value) {
                setState(() {
                  _switchValue = value;
                });
                widget.store.toggleDiscountStatus(widget.index);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Container(
                width: 335,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color(0xFFE1E1E1),
                    width: 0.3,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: widget.product.image != null &&
                        File(widget.product.image!).existsSync()
                    ? Image.file(File(widget.product.image!), fit: BoxFit.cover)
                    : const Icon(Icons.add_photo_alternate, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF007FBA),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('${_calculateSavings(widget.product)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 12))),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF007FBA),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'R\$ ${_calculateValue(widget.product)}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${_oldValue(widget.product)}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        caption: 'Editar desconto',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiscountFormScreen(product: widget.product),
            ),
          );
        },
      ),
    );
  }

  String _calculateSavings(Product product) {
    if (product.discount == null) return '0%';

    switch (product.discount!.type) {
      case 'Percentual':
        return '${product.discount!.percentageDiscount.toStringAsFixed(0)}% Desconto';
      case 'De Por':
        return 'Economize R\$ ${product.discount!.fromPrice - product.discount!.toPrice}';
      case 'Leve + Pague-':
        return 'Leve ${product.discount!.buyQuantity} Pague ${product.discount!.payQuantity}';
      default:
        return '0%';
    }
  }

  String _calculateValue(Product product) {
    if (product.discount == null) return '0.00';

    switch (product.discount!.type) {
      case 'Percentual':
        return formatBrlValue(product.price -
            (product.price * product.discount!.percentageDiscount / 100));
      case 'De Por':
        return formatBrlValue(product.discount!.toPrice);
      case 'Leve + Pague-':
        return formatBrlValue(product.price);
      default:
        return '0.00';
    }
  }

  String _oldValue(Product product) {
    if (product.discount == null) return '0.00';

    switch (product.discount!.type) {
      case 'Percentual':
        return 'R\$ ${formatBrlValue(product.price)}';
      case 'De Por':
        return 'R\$ ${formatBrlValue(product.discount!.fromPrice)}';
      case 'Leve + Pague-':
        return '';
      default:
        return '0.00';
    }
  }
}
