import 'package:course_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/states.dart';
import 'package:course_flutter/modules/shop_app/search_products/search_screen.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <ShopHomeCubit , ShopHomeState>(
        builder: (context , state){
          var cubit = ShopHomeCubit.get(context);
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children:
                [
                   UserAccountsDrawerHeader(
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         fit: BoxFit.cover,
                         image: NetworkImage("https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RE4wyUn?ver=1de8"),
                       ),
                     ),
                     currentAccountPicture: CircleAvatar(
                         child: ClipOval(
                           child: Image(
                             width: 90.0,
                             height: 90.0,
                             fit: BoxFit.cover,
                             image: NetworkImage("https://scontent.fcai19-1.fna.fbcdn.net/v/t1.6435-9/66272838_105865830718286_8755829627953348608_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=GcatjR8PLG4AX-4bYyC&_nc_ht=scontent.fcai19-1.fna&oh=c616135ec79ce395f444178577b82f25&oe=615E4410"),),
                         )
                     ),
                     accountName: Text("Mohamed Afifi"),
                     accountEmail: Text("mohamedafifi5112001@gmail.com"),
                   ),
                  ListTile(
                    onTap: (){
                    },
                    title: Text("Home" ,
                    ),
                    leading: Icon(Icons.home),
                  ),
                  ListTile(
                    onTap: (){},
                    title: Text("Favorites"),
                    leading: Icon(Icons.favorite),
                  ),
                  ListTile(
                    onTap: (){},
                    title: Text("Categories"),
                    leading: Icon(Icons.apps),
                  ),
                  ListTile(
                    onTap: (){},
                    title: Text("Log out"),
                    leading: Icon(Icons.logout),
                  ),

                ],
              ),
            ),
            appBar: AppBar(
              title: Text(
                  "Salla"
              ),
              actions:
              [
                IconButton(onPressed: (){
                  NavigateTo(context, SearchScreen());
                }, icon: Icon(Icons.search)),
              ],
            ),
            body: cubit.screensShopHome[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 10.0,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeCurrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Products'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings'
                ),
              ],
            ),
          );
        },
        listener: (context , state) {

        }
    );
  }
}
