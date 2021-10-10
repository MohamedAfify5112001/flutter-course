import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:course_flutter/shared/components/constants.dart';
import 'package:course_flutter/shared/cubit/cubit.dart';
import 'package:course_flutter/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var dataController = TextEditingController();
  var timeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is insertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.listScreens[cubit.currentIndex],
              fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.showButtonSheet) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        Date: dataController.text,
                        time: timeController.text);
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextInputField(
                              controller: titleController,
                              labelText: "Title",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Title is Required";
                                }
                                return null;
                              },
                              prefixIcon: Icons.title_outlined,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            defaultTextInputField(
                              controller: timeController,
                              labelText: "Time",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Time is Required";
                                }
                                return null;
                              },
                              onTapShow: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                });
                              },
                              prefixIcon: Icons.watch_later_outlined,
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            defaultTextInputField(
                              controller: dataController,
                              keyboardType: TextInputType.datetime,
                              labelText: "Date",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Date is Required";
                                }
                                return null;
                              },
                              onTapShow: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse("2021-08-30"),
                                ).then((value) {
                                  dataController.text =
                                      DateFormat.yMd().format(value!);
                                });
                              },
                              prefixIcon: Icons.date_range_outlined,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
                      .closed
                      .then((value) {
                    cubit.changeFabIcon(
                        isShow: false,
                        icon: Icons.edit
                    );
                  });
                  cubit.changeFabIcon(
                      isShow: true,
                      icon: Icons.add
                  );
                }
              },
              child: Icon(cubit.changeIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archived",
                ),
              ],
            ),
          );
        }
      ),
    );
  }

}
