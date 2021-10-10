import 'package:course_flutter/models/shop_models/products/productsHomeModel.dart';

class GetFavoritesModels
{
  late bool status;
  Data? data;
  GetFavoritesModels.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}
class Data
{
  List<FavoritesData> modelFavorites = [];
  Data.fromJson(Map<String , dynamic> json)
  {
      json['data'].forEach((element){
        modelFavorites.add(FavoritesData.fromJson(element));
      });
  }
}

class FavoritesData {
  ProductsInFavorites? product;
  FavoritesData.fromJson(Map<String , dynamic> json){
    product = ProductsInFavorites.fromJson(json['product']);
  }
}

class ProductsInFavorites
{
   late int id;
   late dynamic price;
   late dynamic oldPrice;
   late dynamic discount;
   late String image;
   late String name;
  ProductsInFavorites.fromJson(Map<String , dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}