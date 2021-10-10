import 'package:course_flutter/layout/news_app_by_api/cubit/cubit.dart';
import 'package:course_flutter/layout/news_app_by_api/cubit/state.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget{
  var SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsAppCubit , NewsAppState>(
      listener: (context , state) {},
      builder: (context , state) {
        var cubitSearch = NewsAppCubit.get(context).Search;
        var cubit = NewsAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                "Search Page"
            ),
          ),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: defaultTextInputField(
                    controller: SearchController,
                    labelText: "Search",
                    hintText: "Search Now",
                    prefixIcon: Icons.search,
                    onChanged: (value){
                      cubit.getDataWhenSearch(value);
                    }
                ),
              ),
              Expanded(child: ListDataNews(cubitSearch, context , isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
