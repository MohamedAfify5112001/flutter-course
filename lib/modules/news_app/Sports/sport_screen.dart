import 'package:course_flutter/layout/news_app_by_api/cubit/cubit.dart';
import 'package:course_flutter/layout/news_app_by_api/cubit/state.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsAppCubit , NewsAppState>(
      listener: (context , state) {

      },
      builder: (context , state){
        var articleSports = NewsAppCubit.get(context).Sports;
        return ListDataNews(articleSports , context);
      },
    );

  }
}
