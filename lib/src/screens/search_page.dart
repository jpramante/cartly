import 'package:cartly/src/controllers/wishlist_controller.dart';
import 'package:cartly/src/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Busca"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        hintText: 'Pesquisar', border: InputBorder.none),
                    onChanged: (value) {
                      Provider.of<WishListController>(context, listen: false)
                          .getSearchResults(value);
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      _controller.clear();
                    },
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Consumer<WishListController>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.searchResults.length,
                itemBuilder: (_, index) => ProductCard(
                  value.searchResults[index],
                ),
                shrinkWrap: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
