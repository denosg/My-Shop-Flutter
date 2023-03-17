import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:my_shop/screens/cart_screens.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/my_badge.dart';

enum FilterOptions {
  favories,
  all,
}

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              switch (value) {
                case FilterOptions.all:
                  productsData.showAll();
                  break;
                case FilterOptions.favories:
                  productsData.showFavoritesOnly();
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favories,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cartData, _2) => MyBadge(
              color: Theme.of(context).accentColor,
              value: cartData.itemCount.toString(),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(),
    );
  }
}
