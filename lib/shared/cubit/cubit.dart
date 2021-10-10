import 'package:bloc/bloc.dart';
import 'package:course_flutter/layout/news_app_by_api/cubit/state.dart';
import 'package:course_flutter/modules/todo_app/archived_screen/archived_screen.dart';
import 'package:course_flutter/modules/todo_app/done_screen/done_screen.dart';
import 'package:course_flutter/modules/todo_app/tasks_screen/tasks_screen.dart';
import 'package:course_flutter/shared/cubit/states.dart';
import 'package:course_flutter/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  var currentIndex = 0;
  List<Widget> listScreens = [TasksScreen(), DoneScreen(), ArchivedScreen()];
  List<String> titles = ["Tasks", "Done", "Archived"];

  AppCubit() : super(initState());

  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(int index) {
    currentIndex = index;
    emit(changeButtonNavigation());
  }

  Database? database;
  List<Map> Newtasks = [];
  List<Map> Donetasks = [];
  List<Map> Archivedtasks = [];

  void createDatabase() {
    openDatabase(
      'todoList.db',
      version: 1,
      onCreate: (database, version) async {
        print("DATABASE IS CREATED");
        await database
            .execute(
            'CREATE TABLE Task (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT)')
            .then((value) {
          print("Table IS CREATED");
        }).catchError((error) {
          print("Error is ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print("DATABASE IS OPENED");
      },
    ).then((value) {
      database = value;
      emit(createDatabaseState());
    });
  }

  //insert To database
  insertToDatabase({required String title,
    required String Date,
    required String time}) async {
    await database!.transaction((txn) {
      txn
          .rawInsert(
          "INSERT INTO Task (title , date , time , status) VALUES ('$title' , '$Date', '$time' , 'new')")
          .then((value) {
        print("$value INSERTED RECORD SUCCESSFULLY");
        getDataFromDatabase(database);
        emit(insertDatabaseState());
      }).catchError((error) {
        print("There is error ${error.toString()}");
      });
      return null;
    });
  }

  void getDataFromDatabase(database) async {
    Newtasks = [];
    Donetasks = [];
    Archivedtasks = [];
    database!.rawQuery('SELECT * FROM Task').then((value) {
      value.forEach((element) {
        //print(element['status']);
        if (element['status'] == 'new') {
          Newtasks.add(element);
        } else if (element['status'] == 'Done') {
          Donetasks.add(element);
        } else if (element['status'] == 'Archived') {
          Archivedtasks.add(element);
        }
      });
      emit(getDatabaseState());
    });
    ;
  }

  void updateDatabase({required String status, required int id}) {
    database!.rawUpdate('UPDATE Task SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      print("Update operation Successfully");
      getDataFromDatabase(database);
      emit(UpdateDatabaseState());
    });
  }

  void deleteDatabase({required int id}) {
    database!.rawDelete(
        'DELETE FROM Task WHERE id = ?', [id]).then((value) {
      print("Delete operation Successfully");
      getDataFromDatabase(database);
      emit(DeleteDatabaseState());
    });
  }

  bool showButtonSheet = false;
  IconData changeIcon = Icons.edit;

  void changeFabIcon({required bool isShow, required IconData icon}) {
    showButtonSheet = isShow;
    changeIcon = icon;
    emit(changeFabIconState());
  }

  bool isDark = false;

  void changeMode({bool ? fromShared}) {
    if(fromShared != null){
      isDark = fromShared;
      emit(ChangeDarkModeStyle());
    }else{
      isDark = !isDark;
      CacheHelper.putBoolean(
          key: 'isDark',
          value: isDark
      ).then((value){
        emit(ChangeDarkModeStyle());
      });
    }

  }
}
