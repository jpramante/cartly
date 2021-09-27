import 'package:cartly/src/controllers/auth.dart';
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
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(user.photoURL!),
                      ),
                    ),
                  ),
                  Text(user.displayName!,
                      style: GoogleFonts.roboto(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 16))),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Wishlist',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            onTap: () {
              Navigator.pushNamed(context, '/wishlist');
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Fazer logout',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            onTap: () {
              context.read<AuthController>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
