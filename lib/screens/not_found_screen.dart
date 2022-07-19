import 'package:flutter/material.dart';

import '../constants/app.dart' as const_app;

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          const_app.appName,
        ),
      ),
      body: const Center(
        child: Text('Ошибка'),
      ),
    );
  }
}
