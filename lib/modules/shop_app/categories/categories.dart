import 'package:course_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/states.dart';
import 'package:course_flutter/models/shop_models/categories_model/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeState>(
      listener: (context, state) => () {},
      builder: (context, state) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => categoriesItems(
                ShopHomeCubit.get(context).modelCategories!.data.models[index]),
            separatorBuilder: (context, index) => Container(
                  height: 0.5,
                  color: Colors.black87,
                  width: double.infinity,
                ),
            itemCount:
                ShopHomeCubit.get(context).modelCategories!.data.models.length);
      },
    );
  }

  Widget categoriesItems(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Image(
            width: 90.0,
            height: 90.0,
            fit: BoxFit.cover,
            image: NetworkImage(model.image),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            model.name,
            style: TextStyle(fontSize: 18.0),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.keyboard_arrow_right_outlined),
          ),
        ],
      ),
    );
  }
}
