import 'package:flutter/material.dart';

import 'loading_widget.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return (url.isNotEmpty)
        ? Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) {
                return child;
              }

              return const LoadingWidget();
            },
            errorBuilder: (context, error, trace) {
              return Icon(
                Icons.photo,
                color: theme.primaryColor,
              );
            },
          )
        : Icon(
            Icons.local_pizza_outlined,
            color: theme.primaryColor,
          );
  }
}
