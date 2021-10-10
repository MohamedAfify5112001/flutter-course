import 'package:course_flutter/models/shop_models/login_model/login_model.dart';

abstract class LoginShopStates{}

class InitialLoginShopStates extends LoginShopStates{}

class SuccessfulLoginShopStates extends LoginShopStates{
  ShopLoginModel ?modelLogin;
  SuccessfulLoginShopStates(this.modelLogin);
}

class LoadingLoginShopStates extends LoginShopStates{}

class ErrorLoginShopStates extends LoginShopStates{
  final String error;
  ErrorLoginShopStates(this.error);
}


class ShowPasswordLoginShopStates extends LoginShopStates{}

class ColorMessageState extends LoginShopStates{}



