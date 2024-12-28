import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/api_service.dart';

class ProductListScreen extends StatelessWidget {
  final int categoryId;

  const ProductListScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);

    return FutureBuilder<List<Product>>(
      future: apiService.fetchProducts(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final products = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
            ),
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      // Expanded(
                      //   child: Image.network(
                      //       // products[index].image,
                      //       //fit: BoxFit.cover,
                      //       ),
                      // ),
                      Text(products[index].name),
                      //Text('\$${products[index].price}'),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
