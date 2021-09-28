import 'package:cartly/src/controllers/auth.dart';
import 'package:cartly/src/res/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.mainColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(Icons.shopping_cart_outlined,
                  size: 120, color: CustomColors.accentColor),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text("CartlyApp",
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(color: CustomColors.loginScreenText),
                      fontSize: 30)),
            ),
            Consumer<AuthController>(
              builder: (context, controller, _) {
                if (controller.isLoading) {
                  return CircularProgressIndicator(
                    color: CustomColors.accentColor,
                  );
                }
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: CustomColors.accentColor,
                    onPrimary: CustomColors.accentColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () {
                    controller.signInWithGoogle();
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.black,
                  ),
                  label: Text('Entrar com Google',
                      style: TextStyle(color: CustomColors.mainTextColor)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
