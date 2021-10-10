import 'package:course_flutter/modules/all_basic_apps/counter/cubit/counter_cubit.dart';
import 'package:course_flutter/modules/all_basic_apps/counter/cubit/states_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {
          if (state is plusStateCounter) {
            print("I in plus State ${state.count}");
          }
          if (state is minusStateCounter) {
            print("I in minus State ${state.count}");
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              'Counter',
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      CounterCubit.getObject(context).minus();
                    },
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 70.0),
                    )),
                Text(
                  "${CounterCubit.getObject(context).counter}",
                  style: TextStyle(fontSize: 50.0),
                ),
                TextButton(
                    onPressed: () {
                      CounterCubit.getObject(context).plus();
                    },
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 40.0),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
