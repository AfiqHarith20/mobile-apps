// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, unnecessary_new, avoid_print, constant_identifier_names, import_of_legacy_library_into_null_safe, unused_local_variable, prefer_final_fields, unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screens.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/products_providers.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screens.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  late final bool showFavs;

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (color, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
