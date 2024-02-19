import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CounterEvent {}
final class IncrementEvent extends CounterEvent{}
final class DecrementEvent extends CounterEvent{}

class CounterBloc extends Bloc<CounterEvent,int>{
  CounterBloc() : super(0){
    on<IncrementEvent>((event,emit) => emit(state+1));
    on<DecrementEvent>((event, emit) => emit(state - 1));
  }
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print('change $change');
  }
}
