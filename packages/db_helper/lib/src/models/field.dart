class Field {
  const Field({
    required this.title,
    required this.type,
    this.nullable = true,
    this.primary = false,
  });

  final String title;
  final Type type;
  final bool nullable;
  final bool primary;
}
