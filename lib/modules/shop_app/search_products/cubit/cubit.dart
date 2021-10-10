import 'package:course_flutter/models/shop_models/seach/search_model.dart';
import 'package:course_flutter/modules/shop_app/search_products/cubit/state.dart';
import 'package:course_flutter/shared/components/constants.dart';
import 'package:course_flutter/shared/network/remote/dio_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void searchProducts(String text){
    emit(LoadingSearchState());
    DioHelper.postData(path: searchAllProducts, data: {
      "text" : text
    } , token: token).then((value){
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchState());
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorSearchState());
    });
  }
}
