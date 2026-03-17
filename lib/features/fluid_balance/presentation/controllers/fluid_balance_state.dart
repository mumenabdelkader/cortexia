part of 'fluid_balance_cubit.dart';

@immutable
abstract class FluidBalanceState {}

class FluidBalanceStateInitial extends FluidBalanceState {}
class FluidBalanceStateLoading extends FluidBalanceState {}
class FluidBalanceStateSuccess extends FluidBalanceState {
  final dynamic data;
  final String operation;
  FluidBalanceStateSuccess({required this.operation, this.data});
}
class FluidBalanceStateError extends FluidBalanceState {
  final String message;
  FluidBalanceStateError({required this.message});
}
