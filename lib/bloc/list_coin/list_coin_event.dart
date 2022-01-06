import 'package:equatable/equatable.dart';

abstract class ListCoinEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListCoinLoaded extends ListCoinEvent {}
