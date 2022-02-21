import 'package:flutter/material.dart';

import 'widgets/home_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      drawer: HomeDrawer(),
      body: Container(),
    );
  }
}
