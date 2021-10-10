import 'package:course_flutter/models/shop_models/products/productsHomeModel.dart';
import 'package:flutter/material.dart';

class DetailsProduct extends StatelessWidget {
  ProductsModel model;

  DetailsProduct(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Showing",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Hero(
              tag: 'images ${model.image}',
              child: Image(
                image: NetworkImage(model.image),
                width: 300.0,
                height: 300.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[100],
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Text(
                     '${model.description}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                      height: 1.5
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
