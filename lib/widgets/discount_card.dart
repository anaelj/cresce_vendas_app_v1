import 'package:cresce_vendas_app_v1/components/custom_switch_tile.dart';
import 'package:cresce_vendas_app_v1/models/product.dart';
import 'package:cresce_vendas_app_v1/screens/discount_detail_screen.dart';
import 'package:cresce_vendas_app_v1/stores/product_store.dart';
import 'package:cresce_vendas_app_v1/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

Widget discountCard(
    BuildContext context, Product product, ProductStore store, int index) {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
    decoration: BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        SizedBox.fromSize(size: Size.fromHeight(8)),
        CustomSwitch(
          value: product.discount?.status ?? false,
          onChanged: (value) => store.toggleDiscountStatus(index),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.3,
                  color: const Color(0xFFE1E1E1),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: EdgeInsets.all(4), // Padding interno
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child:
                      product.image != null && File(product.image!).existsSync()
                          ? Image.file(File(product.image!), fit: BoxFit.cover)
                          : const Icon(Icons.add_photo_alternate, size: 50),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Row(
                      children: [
                        Text(
                          'Desconto',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(product.discount?.type ?? ''),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Data ativação',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text('${formatDate(product.discount?.startDate)}'),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Data inativação',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text('${formatDate(product.discount?.endDate)}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            )),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiscountDetailScreen(
                    product: product, store: store, index: index
                    // store: store,
                    // index: index,
                    ),
              ),
            ).then((_) => store.loadProducts());
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ver Desconto',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              SvgPicture.asset(
                'assets/svg/eye.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
