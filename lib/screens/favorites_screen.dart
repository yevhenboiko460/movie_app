import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites movies'),
        backgroundColor: Colors.orange,
      ),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Empty')),
    );
  }
}
