import 'package:cartly/src/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartly/src/widgets/favorite_button.dart';
import 'package:cartly/src/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product _product;

  const ProductCard(this._product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double price = double.parse(_product.price);
    double promo = double.parse(_product.promo);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 3.0),
      child: Card(
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(_product.name),
          ),
          subtitle: price > promo
              ? RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'R\$$price',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                        text: ' R\$$promo',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                )
              : Text('R\$$price'),
          trailing: FavoriteButton(_product),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  product: _product,
                ),
              ),
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: CachedNetworkImage(
              width: 60,
              height: 60,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageUrl: _product.thumbnail,
            ),
          ),
        ),
      ),
    );
  }
}
