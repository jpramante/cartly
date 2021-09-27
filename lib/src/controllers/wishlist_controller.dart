import 'dart:collection';

import 'package:cartly/src/controllers/controller.dart';
import 'package:cartly/src/models/product_model.dart';
import 'package:cartly/src/screens/catalog_page.dart';
import 'package:dio/dio.dart';

class WishListController extends Controller {
  //this is the catalog we'll get from the api (the base one);
  List<Product> _catalog = [];
  //this is the catalog we'll use for filtering and sorting;
  List<Product> _filteredCatalog = [];

  String _searchTerms = "";

  List<Product> get unfilteredCatalog => _catalog;

  List<Product> get products => _filteredCatalog;

  List<Product> get wishlist =>
      [..._catalog].where((element) => element.favorite == true).toList();

  UnmodifiableListView<Product> get searchResults => _searchTerms.isEmpty
      ? UnmodifiableListView([])
      : UnmodifiableListView(_catalog
          .where((element) => element.name.toLowerCase().contains(_searchTerms))
          .toList());

  getSearchResults(String searchTerms) {
    _searchTerms = searchTerms.toLowerCase();
    notifyListeners();
  }

  toggleFavourite(Product product) {
    int index = _catalog.indexWhere((element) => element.id == product.id);
    _catalog[index].favorite = !_catalog[index].favorite;
    notifyListeners();
  }

  onFilter(Filter filter) {
    _filteredCatalog = _catalog;
    switch (filter) {
      case Filter.alphabetical:
        sortAlphabetically(true);
        break;
      case Filter.reverseAlpha:
        sortAlphabetically(false);
        break;
      case Filter.priceUp:
        sortByPrice(true);
        break;
      case Filter.priceDown:
        sortByPrice(false);
        break;
      case Filter.promo:
        sortByPromo(true);
        break;
      case Filter.noPromo:
        sortByPromo(false);
        break;
      default:
      //This should never happen, but if it does, just return the base catalog;
    }
    notifyListeners();
  }

  sortAlphabetically(bool isAlphabetical) {
    if (isAlphabetical) {
      _filteredCatalog.sort((a, b) => a.name.compareTo(b.name));
    } else {
      _filteredCatalog.sort((b, a) => a.name.compareTo(b.name));
    }
  }

  sortByPrice(bool isUp) {
    if (isUp) {
      _filteredCatalog.sort(
          (a, b) => double.parse(a.price).compareTo(double.parse(b.price)));
    } else {
      _filteredCatalog.sort((b, a) => a.price.compareTo(b.price));
    }
  }

  sortByPromo(bool isPromo) {
    if (isPromo) {
      _filteredCatalog = [..._catalog]
          .where((element) =>
              double.parse(element.price) > double.parse(element.promo))
          .toList();
    } else {
      _filteredCatalog = [..._catalog]
          .where((element) =>
              double.parse(element.price) < double.parse(element.promo))
          .toList();
    }
  }

  //TODO: Implementar on Error e outros estados;
  Future<List<Product>> getCatalogList() async {
    setStatus(Status.loading);
    final dio = Dio();
    var response = await dio.get(
        'https://6147a64265467e0017384bd8.mockapi.io/cartly/api/v1/products');
    _catalog =
        response.data.map<Product>((json) => Product.fromJson(json)).toList();
    _filteredCatalog = _catalog;
    setStatus(Status.success);
    return _catalog;
  }
}
