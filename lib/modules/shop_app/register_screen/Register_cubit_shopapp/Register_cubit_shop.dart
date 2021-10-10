import 'package:bloc/bloc.dart';
import 'package:course_flutter/models/shop_models/login_model/login_model.dart';
import 'package:course_flutter/modules/shop_app/login_screen/login_cubit_shopapp/login_states_shop.dart';
import 'package:course_flutter/modules/shop_app/register_screen/Register_cubit_shopapp/Register_states_shop.dart';
import 'package:course_flutter/shared/components/constants.dart';
import 'package:course_flutter/shared/network/remote/dio_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterShopCubit extends Cubit<RegisterShopStates>{
  RegisterShopCubit() : super(InitialRegisterShopStates());

  static RegisterShopCubit get(context) => BlocProvider.of(context);

  ShopLoginModel ?loginModel;

  bool isSecure = true;
  IconData iconForPassword = Icons.visibility;
  void changeIcon(){
    isSecure = !isSecure;
    iconForPassword = (isSecure) ? Icons.visibility : Icons.visibility_off_outlined ;
    emit(ShowPasswordRegisterShopStates());
  }

  void userRegister({
     required String email
    , required String password,
      required String phone
    , required String name,
  }){
    emit(LoadingRegisterShopStates());
    DioHelper.postData(
        path: register,
        lang: 'en',
        data:
        {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone
        }
    ).then((value){
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel!.status);
      print(loginModel!.message);
      emit(SuccessfulRegisterShopStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ErrorRegisterShopStates(error.toString()));
    });
}

}