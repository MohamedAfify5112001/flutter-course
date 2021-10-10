import 'package:course_flutter/layout/shop_app/shop_cubit/states.dart';
import 'package:course_flutter/models/shop_models/categories_model/categories_model.dart';
import 'package:course_flutter/models/shop_models/favorites/fav_model.dart';
import 'package:course_flutter/models/shop_models/favorites/get_favorites.dart';
import 'package:course_flutter/models/shop_models/login_model/login_model.dart';
import 'package:course_flutter/models/shop_models/products/productsHomeModel.dart';
import 'package:course_flutter/modules/shop_app/categories/categories.dart';
import 'package:course_flutter/modules/shop_app/favorite/favorits.dart';
import 'package:course_flutter/modules/shop_app/products/products.dart';
import 'package:course_flutter/modules/shop_app/settings/settings.dart';
import 'package:course_flutter/shared/components/constants.dart';
import 'package:course_flutter/shared/network/local/cache_helper.dart';
import 'package:course_flutter/shared/network/remote/dio_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopHomeCubit extends Cubit<ShopHomeState> {
  ShopHomeCubit() : super(InitialStateShopHome());
  int currentIndex = 0;
  List<Widget> screensShopHome = [
    ShopProducts(),
    ShopCategories(),
    ShopFavorites(),
    ShopSettings()
  ];

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeBetweenPages());
  }

  HomeModel? model;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingDataStates());
    DioHelper.getDataFromApi(path: homeEndPoint, token: token).then((value) {
      model = HomeModel.fromJson(value.data);
      model!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorite});
      });
      emit(ShopSuccessDataStates());
    }).catchError((error) {
      print("error : ${error.toString()}");
      emit(ShopErrorDataStates());
    });
  }

  CategoriesModel? modelCategories;

  void getCategories() {
    DioHelper.getDataFromApi(path: categoriesEndPoint).then((value) {
      modelCategories = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      print("error : ${error.toString()}");
      emit(ShopErrorCategoriesStates());
    });
  }

  FavoritesModel? favModel;

  void changeFavoriteItem(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopchangeFavoriteStates());
    DioHelper.postData(
            path: favorite, data: {"product_id": productId}, token: token)
        .then((value) {
      favModel = FavoritesModel.fromJson(value.data);
      if (!favModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessFavoriteStates(favModel!.message));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopErrorFavoriteStates());
    });
  }

  GetFavoritesModels? getFavoritesModels;

  void getFavorites() {
    emit(ShopLoadingFavoriteStates());
    DioHelper.getDataFromApi(path: favorite, token: token).then((value) {
      getFavoritesModels = GetFavoritesModels.fromJson(value.data);
      emit(ShopSuccessAllFavoriteStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorAllFavoriteStates());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    DioHelper.getDataFromApi(path: profile , token: token ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataStates(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUserDataStates());
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone})
  {
    DioHelper.updateData(
        path: updateDataOfUser,
        token: token,
         data:
    {
      "name": name,
      "phone": phone,
      "email": email,
    }
    ).then((value){
      emit(ShopLoadingUpdateUserStates());
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserStates(userModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorUpdateUserStates());
    });
  }
  void logoutFromWeb(){
    DioHelper.postDataWithoutData(path: logout , token: token).then((value){
      print(value.data);
      emit(ShopSuccessLogoutStates());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorLogoutStates());
    });
  }
}
