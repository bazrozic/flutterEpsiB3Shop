import 'package:epsi_shop/ui/pages/basket_page.dart';
import 'package:epsi_shop/ui/pages/detail_page.dart';
import 'package:epsi_shop/ui/pages/list_product_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bo/product.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            ListProductPage(listProducts: listProducts),
        routes: [
          GoRoute(
            path: 'detail/:idProduct',
            name: 'detail',
            builder: (context, state) {
              final idProduct =
                  int.tryParse(state.pathParameters['idProduct'] ?? '') ?? 0;
              return DetailPage(idProduct: idProduct);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/basket',
        name: 'basket',
        builder: (context, state) => BasketPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
