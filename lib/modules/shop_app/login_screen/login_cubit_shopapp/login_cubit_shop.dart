import 'package:bloc/bloc.dart';
import 'package:course_flutter/models/shop_models/login_model/login_model.dart';
import 'package:course_flutter/modules/shop_app/login_screen/login_cubit_shopapp/login_states_shop.dart';
import 'package:course_flutter/shared/network/remote/dio_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginShopCubit extends Cubit<LoginShopStates>{
  LoginShopCubit() : super(InitialLoginShopStates());

  static LoginShopCubit get(context) => BlocProvider.of(context);

  ShopLoginModel ?loginModel;

  bool isSecure = true;
  IconData iconForPassword = Icons.visibility;
  void changeIcon(){
    isSecure = !isSecure;
    iconForPassword = (isSecure) ? Icons.visibility : Icons.visibility_off_outlined ;
    emit(ShowPasswordLoginShopStates());
  }

  void userLogin({required String email
    , required String password,
  }){
    emit(LoadingLoginShopStates());
    DioHelper.postData(
        path: "login",
        lang: 'en',
        data:
        {
          'email' : email,
          'password' : password
        }
    ).then((value){
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      emit(SuccessfulLoginShopStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ErrorLoginShopStates(error.toString()));
    });
}

}