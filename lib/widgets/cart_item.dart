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
    //Option to delete the item from the list
    return Dismissible(
      //Alert Dialog
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure ?'),
                content: const Text(
                    'Do you want to remove the item from the cart ?'),
                //Options for the user regarding deleting the product
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('No')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Yes'))
                ],
              );
            });
      },
      //Sets the key for each item so it shows and deletes the right one
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        //Removes the item from the cart (Watch Cart Class for more info regarding .removeItem method)
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      //Creates the deleting UI
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
      //Creates the item from cart UI
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
