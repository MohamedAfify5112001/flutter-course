import 'package:conditional_builder/conditional_builder.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/cubit.dart';
import 'package:course_flutter/layout/shop_app/shop_cubit/states.dart';
import 'package:course_flutter/models/shop_models/favorites/get_favorites.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ShopFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeState>(
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
      },
      builder: (context, state) {
        var cubit = ShopHomeCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingFavoriteStates,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => productsBuilder(
                  cubit.getFavoritesModels!.data!.modelFavorites[index].product,
                  context ),
              separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.black87,
                  ),
              itemCount: cubit.getFavoritesModels!.data!.modelFavorites.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }


}
