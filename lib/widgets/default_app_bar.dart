import 'package:flutter/material.dart';

import '../constants/measures.dart' as const_measures;
import 'return_button.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    required this.title,
    this.action,
    this.leading = const ReturnButton(),
  });

  final String title;
  final Widget? action;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(const_measures.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: const_measures.midPadding,
              ),
              child: leading ?? const SizedBox.shrink(),
            ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: const_measures.midPadding,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: const_measures.midPadding,
            ),
            child: action ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
