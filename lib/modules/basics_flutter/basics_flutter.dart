import 'package:flutter/material.dart';

class BasicsFlutter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.cyan,
          child: Center(child: Text("Welcome In Drawer")),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Basics Flutter",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            children: [
              _buildBackgroundImageProfile(context),
              Transform.translate(
                  offset: Offset(0 , 170),
                  child: _buildImageProfile(context),
              ),
            ],
          ),
           SizedBox(height: 40.0,),
          _buildDetailsProfile(context),
           SizedBox(height: 15.0,),
          _buildActions(context),
        ],
      ) ,
    );
  }
  Widget _buildBackgroundImageProfile(BuildContext context){
    return Image(
      image: AssetImage("assets/images/nature.png"),
    );
  }
  Widget _buildImageProfile(BuildContext context){
    return Center(
      child: Container(
        height: 150.0,
        width: 150.0,
        child: ClipOval(
          child: Image(
            image: NetworkImage("https://scontent.fcai19-1.fna.fbcdn.net/v/t1.6435-9/66272838_105865830718286_8755829627953348608_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=GcatjR8PLG4AX-4bYyC&_nc_ht=scontent.fcai19-1.fna&oh=c616135ec79ce395f444178577b82f25&oe=615E4410"),),
        )
      ),
    );
  }
  Widget _buildDetailsProfile(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text(
              "Mohamed Afifi",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple
              ),
          ),
          SizedBox(height: 10.0,),
          Text(
            "Age : 19",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            "status : junior Student",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildActions(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        _buildIcons(Icons.search , "Searching"),
        SizedBox(width: 20.0,),
        _buildIcons(Icons.email , "Email"),
        SizedBox(width: 20.0,),
        _buildIcons(Icons.facebook , "Facebook"),
      ],
    );
  }
  Widget _buildIcons(IconData icon , String text){
    return Column(
      children:
      [
        Icon(icon , size: 30.0,),
        SizedBox(height: 5.0,),
        Text("$text")
      ],
    );
  }
}

