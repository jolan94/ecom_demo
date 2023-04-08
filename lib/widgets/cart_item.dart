import 'package:ecom_demo/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int _itemCount = 1;

  void _incrementCount() {
    setState(() {
      _itemCount++;
    });
    widget.cartItem.quantity = _itemCount;
    Provider.of<CartProvider>(context, listen: false).updateQuantity(
      widget.cartItem,
      _itemCount,
    );
  }

  void _decrementCount() {
    if (_itemCount > 1) {
      setState(() {
        _itemCount--;
      });
      widget.cartItem.quantity = _itemCount;
      Provider.of<CartProvider>(context, listen: false).updateQuantity(
        widget.cartItem,
        _itemCount,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Dismissible(
      key: ValueKey(widget.cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        cart.removeItem(widget.cartItem);
      },
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$${widget.cartItem.price}'),
                ),
              ),
            ),
            title: Text(widget.cartItem.title),
            subtitle: Text('Total: \$${(widget.cartItem.price * widget.cartItem.quantity).toStringAsFixed(2)}'),
            trailing: FittedBox(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementCount,
                  ),
                  Text('$_itemCount'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementCount,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
