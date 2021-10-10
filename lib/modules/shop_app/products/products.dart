import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/states.dart';
import 'package:course_flutter/models/shop_models/categories_model/categories_model.dart';
import 'package:course_flutter/models/shop_models/products/productsHomeModel.dart';
import 'package:course_flutter/modules/detailsProduct/details.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ShopProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopHomeCubit.get(context).model != null && ShopHomeCubit.get(context).modelCategories != null ,
            builder: (context) =>
                productBuilder(ShopHomeCubit.get(context).model ,ShopHomeCubit.get(context).modelCategories , context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {
          if (state is ShopSuccessFavoriteStates) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "${state.message}",
            backgroundColor: Colors.green,
            textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        );
      }
    });
  }

  Widget productBuilder(HomeModel? model , CategoriesModel? categoriesModel , context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data.banners.map((e) {
              return Image(
                image: NetworkImage('${e.image}'),
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                height: 230.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
                initialPage: 0),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 100.0,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context , index) => categoriesBuilder(categoriesModel!.data.models[index]),
                      separatorBuilder: (context , index) => SizedBox(
                        width: 6.0,
                      ),
                      itemCount: categoriesModel!.data.models.length
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'New Products',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[100],
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.48,
              shrinkWrap: true,
              children: List.generate(model.data.products.length,
                  (index) => productBuilderItems(model.data.products[index] , context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget productBuilderItems(ProductsModel model , context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              GestureDetector(
                onTap: (){
                  NavigateTo(context,
                  DetailsProduct(model)
                  );
                },
                child: Hero(
                  tag: 'images ${model.image}',
                  child: Image(
                    image: NetworkImage(
                      model.image,
                    ),
                    width: 185.0,
                    height: 190.0,
                  ),
                ),
              ),
              if (model.discount != 0 && model.price != model.oldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    if (model.oldPrice != 0 && model.price != model.oldPrice)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopHomeCubit.get(context).changeFavoriteItem(model.id);
                      },
                      icon: Icon(Icons.favorite),
                      iconSize: 20.0,
                      color: ShopHomeCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesBuilder(DataModel dataModel){
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children:
      [
        Image(
          image: NetworkImage(dataModel.image),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100.0,
          color: Colors.black87.withOpacity(.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              dataModel.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          ),
        ),
      ],
    );
  }
}
