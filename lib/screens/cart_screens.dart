import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart' show Cart;
import 'package:my_shop/providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '${cart.totalAmount.toStringAsFixed(2)} ron',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: const Color.fromRGBO(187, 168, 255, 1),
                  ),
                  TextButton(
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clearCart();
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          if (cart.itemCount != 0)
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var id = cart.items.values.toList()[index].id;
                  var productId = cart.items.keys.toList()[index];
                  var price = cart.items.values.toList()[index].price;
                  var quantity = cart.items.values.toList()[index].quantity;
                  var title = cart.items.values.toList()[index].title;
                  return CartItem(
                    id,
                    productId,
                    price,
                    quantity,
                    title,
                  );
                },
                itemCount: cart.itemCount,
              ),
            ),
        ],
      ),
    );
  }
}
