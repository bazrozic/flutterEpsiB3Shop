import 'package:epsi_shop/bo/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../bo/basket.dart';

class DetailPage extends StatelessWidget {
  DetailPage(this.product, {super.key});
  final Product product;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.image, height: 150),
          TitleLinePrice(product: product),
          Description(product: product),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                basket.addProduct(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ajouté au panier")),
                );
              },
              child: const Text("Ajouter au panier"),
            ),
          ),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        product.description,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class TitleLinePrice extends StatelessWidget {
  const TitleLinePrice({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            product.getPrice(),
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}

class ButtonReserverEssai extends StatelessWidget {
  const ButtonReserverEssai({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child:
            ElevatedButton(onPressed: () {}, child: Text("Réserver un essai")),
      ),
    );
  }
}
