import 'package:cartly/src/controllers/auth.dart';
import 'package:cartly/src/controllers/wishlist_controller.dart';
import 'package:cartly/src/res/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';

class CartlyDrawer extends StatelessWidget {
  const CartlyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: CustomColors.mainColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(user.photoURL!),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      user.displayName!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: CustomColors.headerTextColor, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Wishlist',
                style: TextStyle(color: CustomColors.mainColor, fontSize: 16)),
            onTap: () {
              Navigator.pushNamed(context, '/wishlist');
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Fazer logout',
                style: TextStyle(color: CustomColors.mainColor, fontSize: 16)),
            onTap: () {
              context.read<WishListController>().invalidateCatalogs();
              context.read<AuthController>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
