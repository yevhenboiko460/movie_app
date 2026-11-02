import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.orange,
      ),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Search Screen')),
    );
  }
}
