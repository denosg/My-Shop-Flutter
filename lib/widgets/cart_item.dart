import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem(
      this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure ?'),
                content: const Text(
                    'Do you want to remove the item from the cart ?'),
                actions: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('No')),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Yes'))
                ],
              );
            });
      },
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        margin:
            const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 4),
        padding: const EdgeInsets.all(20),
        color: Colors.deepOrange,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin:
            const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: FittedBox(child: Text(price.toString()))),
            ),
            title: Text(title),
            subtitle: Text('Total: ${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
