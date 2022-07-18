// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pizza.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Pizza _$$_PizzaFromJson(Map<String, dynamic> json) => _$_Pizza(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_PizzaToJson(_$_Pizza instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
    };
