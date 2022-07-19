import 'package:flutter/material.dart';

class GradientIconButton extends IconButton {
  const GradientIconButton({
    super.key,
    required super.icon,
    required super.onPressed,
    required this.shaderCallback,
    super.iconSize,
    super.visualDensity,
    super.padding,
    super.alignment,
    super.splashRadius,
    // super.color,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.disabledColor,
    super.mouseCursor,
    super.focusNode,
    super.autofocus,
    super.tooltip,
    super.enableFeedback,
    super.constraints,
  });

  final Shader Function(Rect bounds) shaderCallback;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: shaderCallback,
      child: super.build(context),
    );
  }
}
