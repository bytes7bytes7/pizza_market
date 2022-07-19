import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

class ErrorLabel extends StatelessWidget {
  const ErrorLabel({
    super.key,
    required this.error,
    required this.stackTrace,
    required this.buttonText,
    required this.onPressed,
  });

  final Object error;
  final StackTrace stackTrace;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        children: [
          Text(l10n.error),
          Text('$error\n\n$stackTrace'),
          TextButton(
            onPressed: onPressed,
            child: Text(buttonText),
          )
        ],
      ),
    );
  }
}
