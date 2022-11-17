import 'package:equatable/equatable.dart';

abstract class SearchCoinState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SearchCoinInitialize extends SearchCoinState {}

class SearchCoinSuccess extends SearchCoinState {
  final dynamic data;

  SearchCoinSuccess(this.data);

  @override
  List<Object?> get props => [data];
}
