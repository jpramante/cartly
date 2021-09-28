import 'package:cartly/src/controllers/auth.dart';
import 'package:cartly/src/screens/login_screen.dart';
import 'package:cartly/src/screens/search_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cartly/src/res/theme.dart';
import 'package:cartly/src/screens/catalog_page.dart';
import 'package:cartly/src/screens/wishlist_page.dart';
import 'package:cartly/src/controllers/wishlist_controller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const CartlyApp());
}

class CartlyApp extends StatelessWidget {
  const CartlyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishListController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        title: 'Cartly',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/catalog': (context) => const CatalogPage(),
          '/wishlist': (context) => const WishListPage(),
          '/search': (context) => SearchPage(),
        },
      ),
    );
  }
}
