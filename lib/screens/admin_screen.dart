import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../widgets/widget.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: DefaultAppBar(
        title: l10n.addPizza,
        action: PrimaryButton(
          icon: Icons.add,
          onPressed: () {},
        ),
      ),
    );
  }
}
