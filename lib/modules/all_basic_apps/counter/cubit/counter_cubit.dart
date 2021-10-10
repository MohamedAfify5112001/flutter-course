import 'package:bloc/bloc.dart';
import 'package:course_flutter/modules/all_basic_apps/counter/cubit/states_counter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(intiStateCounter());
  var counter = 1;

  static CounterCubit getObject(context) => BlocProvider.of(context);



  void plus() {
    counter++;
    emit(plusStateCounter(counter));
  }

  void minus() {
    counter--;
    emit(minusStateCounter(counter));
  }
}
