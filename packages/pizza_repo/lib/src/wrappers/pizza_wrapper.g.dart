// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizza_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PizzaWrapper _$$_PizzaWrapperFromJson(Map<String, dynamic> json) =>
    _$_PizzaWrapper(
      id: json['id'] as String,
      pizza: Pizza.fromJson(json['pizza'] as Map<String, dynamic>),
      amount: json['amount'] as int,
      maxAmount: json['maxAmount'] as int,
    );

Map<String, dynamic> _$$_PizzaWrapperToJson(_$_PizzaWrapper instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pizza': instance.pizza,
      'amount': instance.amount,
      'maxAmount': instance.maxAmount,
    };
