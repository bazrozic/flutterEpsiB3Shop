import 'package:epsi_shop/bo/basket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Basket()), // Ajout du panier
      ],
      child: MyApp(),
    ),
  );
}
