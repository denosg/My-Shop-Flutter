import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/product.dart';
import 'package:my_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem(
  //     {required this.id, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          //Title of the product
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black38,
          //Favorite Button
          leading: IconButton(
            onPressed: () {
              product.toggleFavoriteStatus();
            },
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
          ),
          //Add to Card Button
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              //Establishes a connection to the Scaffold of the nearest page (in products_overview) (Toast Like in Android)
              //Scaffold.of(context)
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
