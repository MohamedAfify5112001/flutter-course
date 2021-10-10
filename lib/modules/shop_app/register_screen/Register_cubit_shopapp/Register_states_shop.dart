import 'package:course_flutter/models/shop_models/login_model/login_model.dart';

abstract class RegisterShopStates{}

class InitialRegisterShopStates extends RegisterShopStates{}

class SuccessfulRegisterShopStates extends RegisterShopStates{
  ShopLoginModel ?modelLogin;
  SuccessfulRegisterShopStates(this.modelLogin);
}

class LoadingRegisterShopStates extends RegisterShopStates{}

class ErrorRegisterShopStates extends RegisterShopStates{
  final String error;
  ErrorRegisterShopStates(this.error);
}


class ShowPasswordRegisterShopStates extends RegisterShopStates{}

class ColorRegisterMessageState extends RegisterShopStates{}



