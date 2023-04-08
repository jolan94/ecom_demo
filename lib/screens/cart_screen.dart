import 'package:ecom_demo/providers/cart_provider.dart';
import 'package:ecom_demo/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];

                return ListTile(
                  // leading: Image.network(cartItem.product.image),
                  title: Text(cartItem.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${cartItem.quantity}'),
                      Text('Price: \$${cartItem.price.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          cart.updateQuantity(cartItem, cartItem.quantity - 1);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: () {
                          cart.updateQuantity(cartItem, cartItem.quantity + 1);
                        },
                        icon: const Icon(Icons.add),
                      ),
                      IconButton(
                        onPressed: () {
                          cart.removeItem(cartItem);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
