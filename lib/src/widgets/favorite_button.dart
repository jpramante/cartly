import 'package:cartly/src/controllers/wishlist_controller.dart';
import 'package:cartly/src/res/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:cartly/src/models/product_model.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton(this.product, {Key? key}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: product.favorite
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border_outlined),
      color:
          product.favorite ? CustomColors.likedColor : CustomColors.mainColor,
      onPressed: () {
        Provider.of<WishListController>(context, listen: false)
            .toggleFavourite(product);
      },
    );
  }
}
