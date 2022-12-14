import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ConvertCoinEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SupportedCoinsLoaded extends ConvertCoinEvent {
  SupportedCoinsLoaded();
}

class ConvertCoinLoaded extends ConvertCoinEvent {
  final String id;
  final String currency;
  final double numberBeforeConvert;

  ConvertCoinLoaded(this.id, this.currency, this.numberBeforeConvert);
}

class ChangeColorOfCoinField extends ConvertCoinEvent {
  final Color originalColor;
  final Color convertedColor;

  ChangeColorOfCoinField(this.originalColor, this.convertedColor);
}
