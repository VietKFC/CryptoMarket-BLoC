import 'package:equatable/equatable.dart';

abstract class InvestManagementState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class InvestManagementInitialize extends InvestManagementState {}

class InvestManagementSuccess extends InvestManagementState {
  dynamic data;

  InvestManagementSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class InvestManagementLoading extends InvestManagementState {}

class InvestManagementFailed extends InvestManagementState {
  dynamic error;

  InvestManagementFailed(this.error);

  @override
  List<Object?> get props => [error];
}
