// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pizza.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Pizza _$PizzaFromJson(Map<String, dynamic> json) {
  return _Pizza.fromJson(json);
}

/// @nodoc
mixin _$Pizza {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PizzaCopyWith<Pizza> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PizzaCopyWith<$Res> {
  factory $PizzaCopyWith(Pizza value, $Res Function(Pizza) then) =
      _$PizzaCopyWithImpl<$Res>;
  $Res call({String id, String title, double price, String imageUrl});
}

/// @nodoc
class _$PizzaCopyWithImpl<$Res> implements $PizzaCopyWith<$Res> {
  _$PizzaCopyWithImpl(this._value, this._then);

  final Pizza _value;
  // ignore: unused_field
  final $Res Function(Pizza) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? price = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_PizzaCopyWith<$Res> implements $PizzaCopyWith<$Res> {
  factory _$$_PizzaCopyWith(_$_Pizza value, $Res Function(_$_Pizza) then) =
      __$$_PizzaCopyWithImpl<$Res>;
  @override
  $Res call({String id, String title, double price, String imageUrl});
}

/// @nodoc
class __$$_PizzaCopyWithImpl<$Res> extends _$PizzaCopyWithImpl<$Res>
    implements _$$_PizzaCopyWith<$Res> {
  __$$_PizzaCopyWithImpl(_$_Pizza _value, $Res Function(_$_Pizza) _then)
      : super(_value, (v) => _then(v as _$_Pizza));

  @override
  _$_Pizza get _value => super._value as _$_Pizza;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? price = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_Pizza(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Pizza implements _Pizza {
  const _$_Pizza(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl});

  factory _$_Pizza.fromJson(Map<String, dynamic> json) =>
      _$$_PizzaFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final double price;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'Pizza(id: $id, title: $title, price: $price, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Pizza &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(imageUrl));

  @JsonKey(ignore: true)
  @override
  _$$_PizzaCopyWith<_$_Pizza> get copyWith =>
      __$$_PizzaCopyWithImpl<_$_Pizza>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PizzaToJson(
      this,
    );
  }
}

abstract class _Pizza implements Pizza {
  const factory _Pizza(
      {required final String id,
      required final String title,
      required final double price,
      required final String imageUrl}) = _$_Pizza;

  factory _Pizza.fromJson(Map<String, dynamic> json) = _$_Pizza.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  double get price;
  @override
  String get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_PizzaCopyWith<_$_Pizza> get copyWith =>
      throw _privateConstructorUsedError;
}
