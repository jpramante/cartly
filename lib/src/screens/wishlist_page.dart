import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cartly/src/widgets/product_card.dart';
import 'package:cartly/src/controllers/wishlist_controller.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WishList'),
      ),
      body: Consumer<WishListController>(
        builder: (context, value, child) => value.wishlist.length > 0
            ? ListView.builder(
                itemCount: value.wishlist.length,
                itemBuilder: (_, index) => ProductCard(
                      value.wishlist[index],
                    ))
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        Text("Não existem produtos na sua lista de desejos."),
                  ),
                ),
              ),
      ),
    );
  }
}
