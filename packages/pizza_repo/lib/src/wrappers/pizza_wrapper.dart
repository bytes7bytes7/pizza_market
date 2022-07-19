// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../constants.dart' as pizza_const;

part 'pizza_wrapper.freezed.dart';

part 'pizza_wrapper.g.dart';

@freezed
class PizzaWrapper with _$PizzaWrapper {
  const factory PizzaWrapper({
    @JsonKey(name: pizza_const.id) required String id,
    required String title,
    required double price,
    required String imageUrl,
    required int amount,
    required int maxAmount,
  }) = _PizzaWrapper;

  factory PizzaWrapper.fromJson(Map<String, Object?> json) =>
      _$PizzaWrapperFromJson(json);
}
