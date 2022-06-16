// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import, deprecated_member_use, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe, missing_required_param
// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import './screens/splash_screen.dart';

import './screens/cart_screens.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_providers.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_product_screens.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import './providers/product.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          //.value
          //value = Products()
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrder) => Orders(
            auth.token,
            auth.userId,
            previousOrder == null ? [] : previousOrder.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            }),
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
