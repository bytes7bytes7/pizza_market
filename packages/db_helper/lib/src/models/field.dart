class Field {
  const Field(
    this.title,
    this.type,
    this.nullable,
    this.primary,
  );

  final String title;
  final Type type;
  final bool nullable;
  final bool primary;
}
