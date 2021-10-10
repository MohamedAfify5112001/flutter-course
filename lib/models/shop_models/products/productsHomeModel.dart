class  HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map <String, dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromApi(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel.fromApi(Map <String, dynamic> json){
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromApi(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsModel.fromApi(element));
    });

  }

}

class BannersModel {
  late int id;
  late String image;
  BannersModel.fromApi(Map <String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorite;
  late bool inCart;
  late String description;
  ProductsModel(){}
  ProductsModel.fromApi(Map <String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
  }
}

