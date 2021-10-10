import 'package:course_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:course_flutter/models/shop_models/seach/search_model.dart';
import 'package:course_flutter/modules/shop_app/search_products/cubit/cubit.dart';
import 'package:course_flutter/modules/shop_app/search_products/cubit/state.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchStates>(
        listener: (context , stata) {},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultTextInputField(
                      controller: searchController,
                      labelText: "Search",
                      prefixIcon: Icons.search,
                      keyboardType: TextInputType.text,
                      onSubmit: (value){
                        SearchCubit.get(context).searchProducts(value!);
                      }
                    ),
                    SizedBox(height: 15.0,),
                    if(state is LoadingSearchState) LinearProgressIndicator(),
                    SizedBox(height: 25.0,),
                    if(state is SuccessSearchState)
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => productsBuilderItems(
                              SearchCubit.get(context).searchModel!.data!.modelFavorites[index],
                              context , isOldPrice: false),
                          separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 0.5,
                            color: Colors.black87,
                          ),
                          itemCount: SearchCubit.get(context).searchModel!.data!.modelFavorites.length),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget productsBuilderItems( ProductsInFavorites model, context , {bool isOldPrice = true}) {
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
                    '''${model.image}''',
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
}
