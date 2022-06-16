// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors, import_of_legacy_library_into_null_safe, unused_local_variable, missing_required_param, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_providers.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  late final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //.value
        // create: (c) => products[i],
        value: products[i],
        child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
    );
  }
}
