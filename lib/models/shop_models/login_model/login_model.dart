class ShopLoginModel
{
  bool status = false ;
  String message = 'welcome';
  LoginData? data;
  ShopLoginModel.fromJson(Map <String , dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
  ShopLoginModel(){}
}

class LoginData{
   String ?name;
   String ?email;
   String ?phone;
   String ?token;

  LoginData.fromJson(Map <String , dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
  }
}