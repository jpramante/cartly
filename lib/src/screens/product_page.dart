import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartly/src/controllers/wishlist_controller.dart';
import 'package:cartly/src/models/product_model.dart';
import 'package:cartly/src/res/custom_colors.dart';
import 'package:cartly/src/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double price = double.parse(product.price);
    double promo = double.parse(product.promo);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.mainColor,
        title: Text(product.name,
            style: TextStyle(color: CustomColors.headerTextColor)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedNetworkImage(
            width: 300,
            placeholder: (context, url) =>
                CircularProgressIndicator(color: CustomColors.accentColor),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: CustomColors.accentColor),
            imageUrl: product.thumbnail,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: FittedBox(
                child: price > promo
                    ? RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'De:R\$${price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text: ' Por: R\$${promo.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.red.shade600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        'Preço: R\$${price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
            FittedBox(
              alignment: Alignment.centerLeft,
              child: Consumer<WishListController>(
                  builder: (context, value, child) {
                return FavoriteButton(product);
              }),
            ),
          ]),
          Container(
              child: Text(
                product.description,
                textAlign: TextAlign.justify,
                style: TextStyle(height: 1.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16))
        ],
      ),
    );
  }
}
