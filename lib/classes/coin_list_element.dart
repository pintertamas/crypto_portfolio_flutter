import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coin_list_element.g.dart';

@JsonSerializable()
class CoinListElement {
  @required
  final String id;
  @required
  final String symbol;
  @required
  final String name;

  CoinListElement(
    this.id,
    this.symbol,
    this.name,
    );

  factory CoinListElement.fromJson(Map<String, dynamic> json) => _$CoinListElementFromJson(json);
  Map<String, dynamic> toJson() => _$CoinListElementToJson(this);
}