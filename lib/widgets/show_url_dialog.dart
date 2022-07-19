import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

Future<void> showUrlDialog({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final l10n = context.l10n;

      return AlertDialog(
        title: Text(l10n.image),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: l10n.url,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text(l10n.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
