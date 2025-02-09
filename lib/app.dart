import 'package:epsi_shop/ui/pages/basket_page.dart';
import 'package:epsi_shop/ui/pages/detail_page.dart';
import 'package:epsi_shop/ui/pages/list_product_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bo/product.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            ListProductPage(listProducts: listProducts),
        routes: [
          GoRoute(
            path: 'detail/:id',
            builder: (context, state) {
              final id = _parseProductId(state.pathParameters['id']);
              return id != null ? DetailPage(idProduct: id) : _errorPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/basket',
        builder: (context, state) => BasketPage(),
      ),
    ],
  );

  static int? _parseProductId(String? id) {
    if (id == null || id.isEmpty) return null;
    return int.tryParse(id);
  }

  static Widget _errorPage() {
    return const Scaffold(
      body: Center(
          child: Text("Produit introuvable", style: TextStyle(fontSize: 18))),
    );
  }

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
