import 'package:ecom_demo/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/checkout';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addAddressFormKey = GlobalKey<FormState>();
  String _selectedAddress = '123 Main St, Anytown USA';
  String _couponCode = '';
  String _selectedPaymentMethod = '';
  bool _isCouponApplied = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final subtotal = cart.totalPrice;
    final tax = subtotal * 0.1;
    final serviceCharge = subtotal * 0.1;
    final total = subtotal + tax + serviceCharge;

    List<RadioListTile<String>> _buildAddressList() {
      return [
        RadioListTile(
          title: Text('123 Main St, Anytown USA'),
          value: '123 Main St, Anytown USA',
          groupValue: _selectedAddress,
          onChanged: (value) {
            setState(() {
              _selectedAddress = value!;
            });
          },
        ),
        RadioListTile(
          title: Text('456 Oak St, Anytown USA'),
          value: '456 Oak St, Anytown USA',
          groupValue: _selectedAddress,
          onChanged: (value) {
            setState(() {
              _selectedAddress = value!;
            });
          },
        ),
      ];
    }

    void _showAddAddressSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _addAddressFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Address Line 1',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter address line 1';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Address Line 2',
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'City',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter city';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'State',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter state';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Zip Code',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter zip code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('Save Address'),
                    onPressed: () {
                      if (_addAddressFormKey.currentState!.validate()) {
                        // Save address here
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._buildAddressList(),
                ElevatedButton(
                  child: Text('Add New'),
                  onPressed: () {
                    _showAddAddressSheet(context);
                  },
                ),
                // Text(
                //   'Select Address',
                //   style: TextStyle(fontSize: 18),
                // ),
                // SizedBox(height: 16),
                // RadioListTile(
                //   title: Text('123 Main St, Anytown USA'),
                //   value: '123 Main St, Anytown USA',
                //   groupValue: _selectedAddress,
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedAddress = value.toString();
                //     });
                //   },
                // ),
                // RadioListTile(
                //   title: Text('456 Oak St, Anytown USA'),
                //   value: '456 Oak St, Anytown USA',
                //   groupValue: _selectedAddress,
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedAddress = value.toString();
                //     });
                //   },
                // ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Coupon Code',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _couponCode = value.trim();
                    });
                  },
                ),
                ElevatedButton(
                  child: const Text('Apply Coupon'),
                  onPressed: () {
                    setState(() {
                      _isCouponApplied = true;
                    });
                  },
                ),
                if (_isCouponApplied)
                  Text(
                    'Coupon code $_couponCode applied successfully!',
                    style: const TextStyle(color: Colors.green),
                  ),
                const SizedBox(height: 16),
                const Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18),
                ),
                RadioListTile(
                  title: const Text('Credit Card'),
                  value: 'credit_card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('PayPal'),
                  value: 'paypal',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Text('\$${subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tax (10%)'),
                    Text('\$${tax.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Service Charge (10%)'),
                    Text('\$${serviceCharge.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  child: const Text('Place Order'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement place order functionality
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('Order Placed!'),
                            content: const Text('Your order has been placed successfully.'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
