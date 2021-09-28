import 'dart:collection';

import 'package:cartly/src/controllers/controller.dart';
import 'package:cartly/src/models/product_model.dart';
import 'package:cartly/src/screens/catalog_page.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListController extends Controller {
  //this is the catalog we'll get from the api (the base one);
  List<Product> _catalog = [];
  //this is the catalog we'll use for filtering and sorting;
  List<Product> _filteredCatalog = [];
  //This is a simple list of wishlisted product IDs;
  List<String> wishlistIDs = [];

  var user;

  String _searchTerms = "";

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
    setStatus(Status.success);
  }

  toggleFavourite(Product product) {
    int index = _catalog.indexWhere((element) => element.id == product.id);
    _catalog[index].favorite = !_catalog[index].favorite;
    setStatus(Status.success);
    if (_catalog[index].favorite) {
      wishlistIDs.add(_catalog[index].id);
      setStoredWishlist();
    } else {
      wishlistIDs.remove(_catalog[index].id);
      setStoredWishlist();
    }
  }

  addFavourite(String id) {
    int index = _catalog.indexWhere((element) => element.id == id);
    _catalog[index].favorite = true;
  }

  getStoredWishlist() async {
    String userSpecificKey = user.email! + "_wishlist";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    wishlistIDs = prefs.getStringList(userSpecificKey) ?? [];
    if (wishlistIDs.isNotEmpty) {
      for (String element in wishlistIDs) {
        addFavourite(element);
      }
      setStatus(Status.success);
    }
  }

  setStoredWishlist() async {
    String userSpecificKey = user.email! + "_wishlist";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(userSpecificKey, wishlistIDs);
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
      //Just return the base catalog, which we already defined at the top;
    }
    setStatus(Status.success);
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
      _filteredCatalog.sort((a, b) {
        double aPrice = double.parse(a.price) > double.parse(a.promo)
            ? double.parse(a.promo)
            : double.parse(a.price);
        double bPrice = double.parse(b.price) > double.parse(b.promo)
            ? double.parse(b.promo)
            : double.parse(b.price);

        return aPrice.compareTo(bPrice);
      });
    } else {
      _filteredCatalog.sort((a, b) {
        double aPrice = double.parse(a.price) > double.parse(a.promo)
            ? double.parse(a.promo)
            : double.parse(a.price);
        double bPrice = double.parse(b.price) > double.parse(b.promo)
            ? double.parse(b.promo)
            : double.parse(b.price);

        return bPrice.compareTo(aPrice);
      });
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

  setCurrentUser() {
    user = FirebaseAuth.instance.currentUser;
  }

  invalidateCatalogs() {
    _catalog = [];
    _filteredCatalog = [];
    wishlistIDs = [];
  }

  Future<List<Product>> getCatalogList() async {
    setStatus(Status.loading);
    final dio = Dio();
    var response = await dio.get(
        'https://6147a64265467e0017384bd8.mockapi.io/cartly/api/v1/products');
    _catalog =
        response.data.map<Product>((json) => Product.fromJson(json)).toList();
    _filteredCatalog = _catalog;
    getStoredWishlist();
    setStatus(Status.success);
    return _catalog;
  }
}
