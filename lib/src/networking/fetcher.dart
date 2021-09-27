import 'package:cartly/src/models/products_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// Future<ProductList> fetchCatalog() async {
//   final response = await http.get(Uri.parse(
//       'https://6147a64265467e0017384bd8.mockapi.io/cartly/api/v1/products'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return ProductList.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
