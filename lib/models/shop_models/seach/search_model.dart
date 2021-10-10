import 'package:course_flutter/models/shop_models/products/productsHomeModel.dart';

class SearchModel
{
  late bool status;
  Data? data;
  SearchModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}
class Data
{
  List<ProductsInFavorites> modelFavorites = [];
  Data.fromJson(Map<String , dynamic> json)
  {
    json['data'].forEach((element){
      modelFavorites.add(ProductsInFavorites.fromJson(element));
    });
  }
}


class ProductsInFavorites
{
   int? id ;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
   String? image;
   String? name;
  ProductsInFavorites.fromJson(Map<String , dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}