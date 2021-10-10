import 'package:course_flutter/models/users/users_model.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> user = [
    UserModel(id: 1, Name: "Mohamed Afifi", phone: "+0201007847748"),
    UserModel(id: 2, Name: "Safaa Mohamed", phone: "+0201007847748"),
    UserModel(id: 3, Name: "Nada Afifi", phone: "+0201007847748"),
    UserModel(id: 4, Name: "Nour Afifi", phone: "+0201007847748"),
    UserModel(id: 5, Name: "Sou Hesham", phone: "+0201007847748"),
    UserModel(id: 7, Name: "Salma Mostafa", phone: "+0201007847748"),
    UserModel(id: 8, Name: "Salma Mostafa", phone: "+0201007847748"),
    UserModel(id: 9, Name: "Salma Mostafa", phone: "+0201007847748"),
    UserModel(id: 10, Name: "Salma Mostafa", phone: "+0201007847748"),
    UserModel(id: 11, Name: "Salma Mostafa", phone: "+0201007847748"),
    UserModel(id: 12, Name: "Salma Mostafa", phone: "+0201007847748"),
  ];
  Widget UsersItems(UserModel user) => Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.green,
          radius: 28.0,
          child: Text(
            '${user.id}',
            style: TextStyle(
                fontWeight: FontWeight.bold ,
                color: Colors.white,
                fontSize: 32.0),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.Name}" ,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),
              ),
              Text(
                '${user.phone}' ,
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 10.0
                ),
              ),
            ],
          ),
        )
      ],
    ),
  ) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Users" ,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context , index)=> UsersItems(user[index]),
          separatorBuilder: (context , index)=> Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          itemCount: user.length
      ) ,
    );
  }
}
