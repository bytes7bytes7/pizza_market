import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Pizza',
          style: theme.textTheme.headline5,
        ),
        leading: SmallIconButton(
          icon: Icons.arrow_back_ios,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          SmallIconButton(
            icon: Icons.add,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
