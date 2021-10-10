import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  Widget ListStoryItems() => Container(
        width: 60.0,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      "https://scontent.fcai20-6.fna.fbcdn.net/v/t1.6435-9/66272838_105865830718286_8755829627953348608_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=4rGyMKwuDrcAX-CFBW9&_nc_ht=scontent.fcai20-6.fna&oh=028cc82294961ba35de1ee99a553fd4a&oe=60FF5810"),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(bottom: 2.0, end: 1.0),
                  child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Mohamed Afifi Abd Elhafez",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.0),
            )
          ],
        ),
      );

  Widget ListChatsItems() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    "https://scontent.fcai20-6.fna.fbcdn.net/v/t1.6435-9/66272838_105865830718286_8755829627953348608_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=4rGyMKwuDrcAX-CFBW9&_nc_ht=scontent.fcai20-6.fna&oh=028cc82294961ba35de1ee99a553fd4a&oe=60FF5810"),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.only(bottom: 2.0, end: 1.0),
                child: CircleAvatar(
                  radius: 7.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mohamed Afifi" , style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "I am Mohamed Afifi , Hello i am very happy to talk with you",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                    ),
                    Text("02:30 pm")
                  ],
                )
              ],
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 26.0,
              backgroundImage: NetworkImage(
                  "https://scontent.fcai20-6.fna.fbcdn.net/v/t1.6435-9/66272838_105865830718286_8755829627953348608_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=4rGyMKwuDrcAX-CFBW9&_nc_ht=scontent.fcai20-6.fna&oh=028cc82294961ba35de1ee99a553fd4a&oe=60FF5810"),
            ),
            SizedBox(
              width: 13.0,
            ),
            Text(
              "Chats",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20.0,
              ),
              radius: 18.0,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20.0,
              ),
              radius: 18.0,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text("Search")
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ListStoryItems(),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 10.0,
                        ),
                    itemCount: 10),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:  (context , index) => ListChatsItems(),
                  separatorBuilder: (context , index) => SizedBox(height: 12.0,),
                  itemCount: 20
              )
            ],
          ),
        ),
      ),
    );
  }
}
