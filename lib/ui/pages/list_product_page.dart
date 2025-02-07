import 'dart:convert';

import 'package:epsi_shop/bo/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../bo/basket.dart';

class ListProductPage extends StatelessWidget {
  final List<Product> listProducts;

  const ListProductPage({super.key, required this.listProducts});

  Future<List<Product>> getProducts() async {
    Response res = await get(Uri.parse("https://fakestoreapi.com/products"));
    if (res.statusCode == 200) {
      List<dynamic> listMapProducts = jsonDecode(res.body);
      return listMapProducts.map((lm) => Product.fromMap(lm)).toList();
    }
    return Future.error("Erreur de téléchargement");
  }

  @override
  Widget build(BuildContext context) {
    final basket = Provider.of<Basket>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Produits'),
        actions: [
          Stack(
            clipBehavior: Clip.none, // Permet de faire dépasser l'indicateur
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => context.go("/basket"),
              ),
              if (basket.items.isNotEmpty)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      basket.items.length
                          .toString(), // Nombre d'articles dans le panier
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            final listProducts = snapshot.data!;
            return ListViewProducts(listProducts: listProducts);
          } else {
            return const Text("Erreur");
          }
        },
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  const ListViewProducts({
    super.key,
    required this.listProducts,
  });

  final List<Product> listProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listProducts.length,
        itemBuilder: (ctx, index) => InkWell(
              onTap: () => ctx.go("/detail/${listProducts[index].id}"),
              // /detail/4
              child: ListTile(
                leading: Image.network(
                  listProducts[index].image,
                  width: 90,
                  height: 90,
                ),
                title: Text(listProducts[index].title),
                subtitle: Text(listProducts[index].getPrice()),
              ),
            ));
  }
}
