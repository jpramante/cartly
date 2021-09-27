import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartly/src/controllers/wishlist_controller.dart';
import 'package:cartly/src/models/product_model.dart';
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
        title: Text(product.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedNetworkImage(
            width: 300,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
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
                              text: 'De:R\$$price',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text: ' Por: R\$$promo',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        'Preço: R\$$price',
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
