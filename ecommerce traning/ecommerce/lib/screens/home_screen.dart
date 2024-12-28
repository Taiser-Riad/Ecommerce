// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);

    return FutureBuilder<List<Category>>(
      future: apiService.fetchCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final categories = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index].name),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/products',
                      arguments: categories[index].id,
                    );
                  },
                );
              },
            ),
          );
        }
      },
    );
  }
}