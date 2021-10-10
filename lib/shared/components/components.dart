import 'dart:ffi';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:course_flutter/modules/news_app/web_view_screen/webview_screen.dart';
import 'package:course_flutter/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

// Shared Material Button
Widget defaultMatrialButton({
  required String text,
  Color colorbutton = Colors.blue,
  double widthbutton = double.infinity,
  required VoidCallback WhenPressed,
  bool isUpperCase = true,
  required double Borderradius,
}) =>
    Container(
      width: widthbutton,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Borderradius),
        color: colorbutton,
      ),
      child: MaterialButton(
        height: 50.0,
        onPressed: WhenPressed,
        child: Text(
          "${isUpperCase ? text.toUpperCase() : text}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );

// Shared TextInputField

Widget defaultTextInputField(
        {required TextEditingController controller,
        TextInputType? keyboardType,
        ValueChanged<String>? onChanged,
        VoidCallback? suffixSubmit,
        String? Function(String?)? validator,
        String? Function(String?)? onSubmit,
        required String labelText,
        String? hintText,
        required IconData prefixIcon,
        IconData? suffixIcon,
        bool isPasswordSecure = false,
        VoidCallback? showPassword,
        VoidCallback? onTapShow}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      obscureText: isPasswordSecure,
      onTap: onTapShow,
      onFieldSubmitted: onSubmit ,
      validator: validator,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: (suffixIcon == null)
              ? null
              : IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: showPassword,
                )),
    );

//Tasks
Widget tasksData(Map model, context) {
  return Dismissible(
    key: Key('${model['id']}'),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 45.0,
            child: Text(
              '${model['time']}',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model['title']}",
                  style: TextStyle(fontSize: 25.0),
                ),
                Text(
                  "${model['date']}",
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateDatabase(status: 'Done', id: model['id']);
            },
            icon: Icon(Icons.check_box),
            color: Colors.green,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateDatabase(status: 'Archived', id: model['id']);
            },
            icon: Icon(Icons.archive),
            color: Colors.black26,
          )
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteDatabase(id: model['id']);
    },
  );
}

Widget tasksBuilder({required List<Map> tasks}) {
  return ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) => tasksData(tasks[index], context),
        separatorBuilder: (context, index) => Container(
              height: 1.0,
              color: Colors.grey,
            ),
        itemCount: tasks.length),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            color: Colors.black26,
            size: 80.0,
          ),
          Text(
            "No Tasks Yet , Please Add New Tasks",
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          ),
        ],
      ),
    ),
  );
}

Widget buildArticleitem(articles, context) => InkWell(
      onTap: () {
        NavigateTo(context, WebViewScreen(articles['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Container(
              width: 150.0,
              height: 140.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "${articles['urlToImage'] ?? "https://th.bing.com/th/id/OIP.RYjGUFITqyVyyPj7Uk2NHwAAAA?pid=ImgDet&w=300&h=200&rs=1"}"),
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "${articles['title']}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      "${articles['publishedAt']}",
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget ListDataNews(articles, context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: articles.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleitem(articles[index], context),
          separatorBuilder: (context, index) => Container(
                height: 1.0,
                color: Colors.grey,
              ),
          itemCount: 10),
      fallback: (context) => Center(
        child: isSearch ? Container() : CircularProgressIndicator(),
      ),
    );

void NavigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}


void pushAndRemoveUntilPageTo(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false,
  );
}

Widget defaultText({
  String? title,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color
}){
  return Text(
    "$title",
    style: TextStyle(
      fontSize: fontSize ,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

Widget productsBuilder(model, context , {bool isOldPrice = true}) {
  return Padding(
    padding: const EdgeInsets.all(25.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 110.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  '''${model!.image}''',
                ),
                width: 110.0,
                //fit: BoxFit.cover,
                height: 110.0,
              ),
              if (model.discount != 0 &&
                  model.price != model.oldPrice && isOldPrice)
                Container(
                  color: Colors.red,
                  padding:
                  EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Container(
            height: 110.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    if (model.discount != 0 &&
                        model.price != model.oldPrice  && isOldPrice)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopHomeCubit.get(context)
                            .changeFavoriteItem(model.id!);
                      },
                      icon: Icon(Icons.favorite),
                      iconSize: 20.0,
                      color: ShopHomeCubit.get(context).favorites[model.id]!
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}