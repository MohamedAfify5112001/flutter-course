import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              print("My Menu");
            },
            icon: Icon(Icons.menu),
          ),
          title: Text("My Application"),
          actions: [
            IconButton(
                onPressed: () {
                  print("Hello World ;");
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  print("Press in this button");
                },
                icon: Icon(Icons.notification_add))
          ],
        ),
        body: Column(
          children: [
            Container(
              width: 300.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://th.bing.com/th/id/R.be917c906ed9f597840ba1b6d8922667?rik=IaQDtrhoJEYeKA&pid=ImgRaw'),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(.2),
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          "The Blue Sea",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
