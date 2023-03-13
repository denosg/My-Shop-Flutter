import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final Double price;

  // const ProductDetailScreen({super.key, required this.title, required this.price});
  static const routeName = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    //listen: false makes it so the build() is not  rerun when a new product is added in the background
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
