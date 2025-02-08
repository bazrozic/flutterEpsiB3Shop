import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../bo/basket.dart';

class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var basket = Provider.of<Basket>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Panier"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go("/"),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: basket.items.isEmpty
                ? const Center(child: Text("Votre panier est vide"))
                : ListView.builder(
                    itemCount: basket.items.length,
                    itemBuilder: (context, index) {
                      final product = basket.items[index];
                      return ListTile(
                        leading: Image.network(product.image, width: 50),
                        title: Text(product.title),
                        subtitle: Text(product.getPrice()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            basket.removeProduct(product);
                          },
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Total TTC : ${(basket.totalPrice * 1.2).toStringAsFixed(2)}€",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Total HT : ${(basket.totalPrice).toStringAsFixed(2)}€",
                style: Theme.of(context).textTheme.titleSmall,
              )),
          if (basket.items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  basket.clearBasket();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Commande passée !")),
                  );
                },
                child: const Text("Procéder au paiement"),
              ),
            ),
        ],
      ),
    );
  }
}
