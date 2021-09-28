import 'package:cartly/src/controllers/wishlist_controller.dart';
import 'package:cartly/src/res/custom_colors.dart';
import 'package:cartly/src/widgets/drawer.dart';
import 'package:cartly/src/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Filter { alphabetical, reverseAlpha, promo, noPromo, priceUp, priceDown }

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<WishListController>(context, listen: false).setCurrentUser();
      Provider.of<WishListController>(context, listen: false).getCatalogList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CartlyDrawer(),
      appBar: AppBar(
        title: Text('Catálogo',
            style: TextStyle(color: CustomColors.headerTextColor)),
        actions: [
          PopupMenuButton<Filter>(
            icon: const Icon(Icons.filter_list),
            onSelected: (Filter result) {
              setState(
                () {
                  Provider.of<WishListController>(context, listen: false)
                      .onFilter(result);
                },
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Filter>>[
              const PopupMenuItem<Filter>(
                value: Filter.alphabetical,
                child: Text('Ordenar alfabeticamente (A - Z)'),
              ),
              const PopupMenuItem<Filter>(
                value: Filter.reverseAlpha,
                child: Text('Ordenar alfabeticamente (Z - A)'),
              ),
              const PopupMenuItem<Filter>(
                value: Filter.priceUp,
                child: Text('Preço crescente'),
              ),
              const PopupMenuItem<Filter>(
                value: Filter.priceDown,
                child: Text('Preço decrescente'),
              ),
              const PopupMenuItem<Filter>(
                value: Filter.promo,
                child: Text('Produtos com desconto'),
              ),
              const PopupMenuItem<Filter>(
                value: Filter.noPromo,
                child: Text('Produtos sem desconto'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
        ],
      ),
      body: Consumer<WishListController>(
        builder: (context, value, child) => value.hasSuccess
            ? ListView.builder(
                itemCount: value.products.length,
                itemBuilder: (_, index) => ProductCard(
                  value.products[index],
                ),
                shrinkWrap: true,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
