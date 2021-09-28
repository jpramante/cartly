import 'package:cartly/src/controllers/auth.dart';
import 'package:cartly/src/res/custom_colors.dart';
import 'package:cartly/src/widgets/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/src/provider.dart';

import 'catalog_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: CustomColors.mainColor,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CatalogPage();
            } else if (snapshot.hasError) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Algo deu errado. Tente novamente!',
                        style: TextStyle(color: CustomColors.mainTextColor)),
                    IconButton(
                        onPressed: () {
                          Provider.of<AuthController>(context, listen: false)
                              .signInWithGoogle();
                        },
                        icon: Icon(Icons.autorenew,
                            size: 24, color: CustomColors.accentColor))
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child:
                    CircularProgressIndicator(color: CustomColors.accentColor),
              );
            } else {
              return const SignupWidget();
            }
          },
        ),
      ),
    );
  }
}
