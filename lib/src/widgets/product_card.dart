import 'package:cartly/src/res/custom_colors.dart';
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
                        text: 'R\$${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: CustomColors.mainTextColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                        text: ' R\$${promo.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.red.shade800),
                      ),
                    ],
                  ),
                )
              : Text('R\$${price.toStringAsFixed(2)}',
                  style: TextStyle(color: CustomColors.mainTextColor)),
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
            borderRadius: BorderRadius.circular(30.0),
            child: CachedNetworkImage(
              width: 55,
              height: 55,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  CircularProgressIndicator(color: CustomColors.accentColor),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: CustomColors.accentColor),
              imageUrl: _product.thumbnail,
            ),
          ),
        ),
      ),
    );
  }
}
