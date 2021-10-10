import 'package:course_flutter/models/shop_models/login_model/login_model.dart';

abstract class ShopHomeState {}

class InitialStateShopHome extends ShopHomeState {}

class ChangeBetweenPages extends ShopHomeState {}

class ShopLoadingDataStates extends ShopHomeState {}

class ShopSuccessDataStates extends ShopHomeState {}

class ShopErrorDataStates extends ShopHomeState {}

class ShopSuccessCategoriesStates extends ShopHomeState {}

class ShopErrorCategoriesStates extends ShopHomeState {}

class ShopSuccessFavoriteStates extends ShopHomeState {
  late String message;
  ShopSuccessFavoriteStates(this.message);
}
class ShopchangeFavoriteStates extends ShopHomeState {}
class ShopErrorFavoriteStates extends ShopHomeState {}

class ShopSuccessAllFavoriteStates extends ShopHomeState {
}
class ShopLoadingFavoriteStates extends ShopHomeState {}
class ShopErrorAllFavoriteStates extends ShopHomeState {}

class ShopSuccessUserDataStates extends ShopHomeState {
  final ShopLoginModel model;
  ShopSuccessUserDataStates(this.model);
}
class ShopErrorUserDataStates extends ShopHomeState {}

class ShopSuccessUpdateUserStates extends ShopHomeState {
  final ShopLoginModel model;
  ShopSuccessUpdateUserStates(this.model);
}
class ShopLoadingUpdateUserStates extends ShopHomeState {}
class ShopErrorUpdateUserStates extends ShopHomeState {}
class ShopSuccessLogoutStates extends ShopHomeState {
}
class ShopErrorLogoutStates extends ShopHomeState {
}







