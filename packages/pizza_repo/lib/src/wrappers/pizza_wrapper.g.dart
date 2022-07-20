// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizza_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PizzaWrapper _$$_PizzaWrapperFromJson(Map<String, dynamic> json) =>
    _$_PizzaWrapper(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      amount: json['amount'] as int,
      maxAmount: json['maxAmount'] as int,
    );

Map<String, dynamic> _$$_PizzaWrapperToJson(_$_PizzaWrapper instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'amount': instance.amount,
      'maxAmount': instance.maxAmount,
    };
