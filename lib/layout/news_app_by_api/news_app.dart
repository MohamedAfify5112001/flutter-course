import 'package:course_flutter/layout/news_app_by_api/cubit/cubit.dart';
import 'package:course_flutter/layout/news_app_by_api/cubit/state.dart';
import 'package:course_flutter/modules/news_app/search_screen/search_screen.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:course_flutter/shared/cubit/cubit.dart';
import 'package:course_flutter/shared/network/remote/dio_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "News App",
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    NavigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search)
              ),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeMode();
                  },
                  icon: (AppCubit.get(context).isDark) ?  Icon(Icons.wb_sunny) : Icon(Icons.nightlight_round)
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: cubit.items,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIconNavigator(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
