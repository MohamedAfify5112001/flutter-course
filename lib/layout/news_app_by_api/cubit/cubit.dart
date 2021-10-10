import 'package:bloc/bloc.dart';
import 'package:course_flutter/layout/news_app_by_api/cubit/state.dart';
import 'package:course_flutter/modules/news_app/Business/business_screen.dart';
import 'package:course_flutter/modules/news_app/Science/science_screen.dart';
import 'package:course_flutter/modules/news_app/Sports/sport_screen.dart';
import 'package:course_flutter/shared/network/remote/dio_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsAppCubit extends Cubit<NewsAppState> {
  NewsAppCubit() : super(InitState());
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];
  int currentIndex = 0;

  static NewsAppCubit get(context) => BlocProvider.of(context);

  void changeIconNavigator(int index) {
    currentIndex = index;
    if (index == 1) {
      getSportsData();
    }
    if (index == 2) {
      getScienceData();
    }
    emit(ChangeButtonNavigatorBar());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(getBusinessStateLoadingData());
    if (business.length == 0) {
      DioHelper.getDataFromApi(path: "v2/top-headlines", query: {
        "country": "eg",
        "category": "business",
        "apiKey": "3ff34c00460d42828ea13fd3c5ccf50d"
      }).then((value) {
        // print(value.data["articles"][0]['title']);
        business = value.data["articles"];
        emit(getBusinessState());
      }).catchError((error) {
        print(error.toString());
        emit(getDataErrorState(error.toString()));
      });
    } else {
      emit(getBusinessState());
    }
  }

  List<dynamic> Sports = [];

  void getSportsData() {
    emit(getBusinessStateLoadingData());
    if (Sports.length == 0) {
      DioHelper.getDataFromApi(path: "v2/top-headlines", query: {
        "country": "eg",
        "category": "sports",
        "apiKey": "3ff34c00460d42828ea13fd3c5ccf50d"
      }).then((value) {
        // print(value.data["articles"][0]['title']);
        Sports = value.data["articles"];
        emit(getSportsState());
      }).catchError((error) {
        print(error.toString());
        emit(getDataErrorState(error.toString()));
      });
    } else {
      emit(getSportsState());
    }
  }

  List<dynamic> Science = [];

  void getScienceData() {
    emit(getBusinessStateLoadingData());
    if (Science.length == 0) {
      DioHelper.getDataFromApi(path: "v2/top-headlines", query: {
        "country": "eg",
        "category": "science",
        "apiKey": "3ff34c00460d42828ea13fd3c5ccf50d"
      }).then((value) {
        // print(value.data["articles"][0]['title']);
        Science = value.data["articles"];
        emit(getScienceState());
      }).catchError((error) {
        print(error.toString());
        emit(getDataErrorState(error.toString()));
      });
    } else {
      emit(getScienceState());
    }
  }

  List<dynamic> Search = [];

  void getDataWhenSearch(String value) {
    emit(getBusinessStateLoadingData());
    DioHelper.getDataFromApi(path: "v2/everything", query: {
      "q": "$value",
      "apiKey": "3ff34c00460d42828ea13fd3c5ccf50d"
    }).then((value) {
      // print(value.data["articles"][0]['title']);
      Search = value.data["articles"];
      emit(GetDataWhenSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(getDataErrorState(error.toString()));
    });
  }

}
