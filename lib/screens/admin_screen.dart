import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;
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
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.addPizza,
          style: theme.textTheme.headline5,
        ),
        leading: SecondaryButton(
          icon: Icons.arrow_back_ios_new_rounded,
          buttonSize: const_measures.midButtonSize,
          iconSize: const_measures.midIconSize,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          PrimaryButton(
            icon: Icons.add,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
