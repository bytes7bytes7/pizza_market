import 'package:flutter/material.dart';

const _size = 30.0;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: _size,
        width: _size,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
