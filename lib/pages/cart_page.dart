import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cart.isNotEmpty ? ListView.builder(
          itemCount: cart.length,
          itemBuilder: ((context, index) {
            final cartItem = cart[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cartItem['imageUrl'] as String),
                radius: 30,
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Delete Product', style: Theme.of(context).textTheme.titleMedium),
                      content: const Text('Are you sure you want to delete this product from cart?'),
                      actions: [
                        TextButton(
                          onPressed: (){
                             Navigator.of(context).pop();
                          }, 
                          child: const Text('No', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                          ),
                          TextButton(onPressed: (){
                            Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                            Navigator.of(context).pop();
                            
                          }, child: const Text('Yes', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),))
                      ],
                    );
                  });
                },
                icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
              ),
              title: Text(
                cartItem['title'] as String,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cartItem['size']}'),
            );
          })) : Center(child: Text('Nothing Found', style: Theme.of(context).textTheme.titleMedium,))
    );
  }
}
