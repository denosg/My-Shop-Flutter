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
    //Collects the data from ProductsProvider (hover over productsData for more context)
    final productsData = Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          //The Filters regarding Favorite or All products
          PopupMenuButton(
            //When pressing on a list item
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
            //PopupMenuButton takes an itemBuilder argument with multiple children for the list of choices
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
          //Rebuilds only this part with the different data because of Consumer<Cart>
          //(something like Provider, but only for this part of app)
          Consumer<Cart>(
            //Shows the cart badge with the amount of products in the top right corner
            builder: (_, cartData, _2) => MyBadge(
              color: Theme.of(context).accentColor,
              //Hover over cartData for more context (builder aswell)
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
