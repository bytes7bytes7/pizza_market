// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pizza_wrapper.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PizzaWrapper _$PizzaWrapperFromJson(Map<String, dynamic> json) {
  return _PizzaWrapper.fromJson(json);
}

/// @nodoc
mixin _$PizzaWrapper {
  String get id => throw _privateConstructorUsedError;
  Pizza get pizza => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get maxAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PizzaWrapperCopyWith<PizzaWrapper> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PizzaWrapperCopyWith<$Res> {
  factory $PizzaWrapperCopyWith(
          PizzaWrapper value, $Res Function(PizzaWrapper) then) =
      _$PizzaWrapperCopyWithImpl<$Res>;
  $Res call({String id, Pizza pizza, int amount, int maxAmount});

  $PizzaCopyWith<$Res> get pizza;
}

/// @nodoc
class _$PizzaWrapperCopyWithImpl<$Res> implements $PizzaWrapperCopyWith<$Res> {
  _$PizzaWrapperCopyWithImpl(this._value, this._then);

  final PizzaWrapper _value;
  // ignore: unused_field
  final $Res Function(PizzaWrapper) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? pizza = freezed,
    Object? amount = freezed,
    Object? maxAmount = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pizza: pizza == freezed
          ? _value.pizza
          : pizza // ignore: cast_nullable_to_non_nullable
              as Pizza,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAmount: maxAmount == freezed
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $PizzaCopyWith<$Res> get pizza {
    return $PizzaCopyWith<$Res>(_value.pizza, (value) {
      return _then(_value.copyWith(pizza: value));
    });
  }
}

/// @nodoc
abstract class _$$_PizzaWrapperCopyWith<$Res>
    implements $PizzaWrapperCopyWith<$Res> {
  factory _$$_PizzaWrapperCopyWith(
          _$_PizzaWrapper value, $Res Function(_$_PizzaWrapper) then) =
      __$$_PizzaWrapperCopyWithImpl<$Res>;
  @override
  $Res call({String id, Pizza pizza, int amount, int maxAmount});

  @override
  $PizzaCopyWith<$Res> get pizza;
}

/// @nodoc
class __$$_PizzaWrapperCopyWithImpl<$Res>
    extends _$PizzaWrapperCopyWithImpl<$Res>
    implements _$$_PizzaWrapperCopyWith<$Res> {
  __$$_PizzaWrapperCopyWithImpl(
      _$_PizzaWrapper _value, $Res Function(_$_PizzaWrapper) _then)
      : super(_value, (v) => _then(v as _$_PizzaWrapper));

  @override
  _$_PizzaWrapper get _value => super._value as _$_PizzaWrapper;

  @override
  $Res call({
    Object? id = freezed,
    Object? pizza = freezed,
    Object? amount = freezed,
    Object? maxAmount = freezed,
  }) {
    return _then(_$_PizzaWrapper(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      pizza: pizza == freezed
          ? _value.pizza
          : pizza // ignore: cast_nullable_to_non_nullable
              as Pizza,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      maxAmount: maxAmount == freezed
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PizzaWrapper implements _PizzaWrapper {
  const _$_PizzaWrapper(
      {required this.id,
      required this.pizza,
      required this.amount,
      required this.maxAmount});

  factory _$_PizzaWrapper.fromJson(Map<String, dynamic> json) =>
      _$$_PizzaWrapperFromJson(json);

  @override
  final String id;
  @override
  final Pizza pizza;
  @override
  final int amount;
  @override
  final int maxAmount;

  @override
  String toString() {
    return 'PizzaWrapper(id: $id, pizza: $pizza, amount: $amount, maxAmount: $maxAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PizzaWrapper &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.pizza, pizza) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.maxAmount, maxAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(pizza),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(maxAmount));

  @JsonKey(ignore: true)
  @override
  _$$_PizzaWrapperCopyWith<_$_PizzaWrapper> get copyWith =>
      __$$_PizzaWrapperCopyWithImpl<_$_PizzaWrapper>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PizzaWrapperToJson(
      this,
    );
  }
}

abstract class _PizzaWrapper implements PizzaWrapper {
  const factory _PizzaWrapper(
      {required final String id,
      required final Pizza pizza,
      required final int amount,
      required final int maxAmount}) = _$_PizzaWrapper;

  factory _PizzaWrapper.fromJson(Map<String, dynamic> json) =
      _$_PizzaWrapper.fromJson;

  @override
  String get id;
  @override
  Pizza get pizza;
  @override
  int get amount;
  @override
  int get maxAmount;
  @override
  @JsonKey(ignore: true)
  _$$_PizzaWrapperCopyWith<_$_PizzaWrapper> get copyWith =>
      throw _privateConstructorUsedError;
}
