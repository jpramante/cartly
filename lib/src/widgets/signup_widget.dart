import 'package:cartly/src/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<AuthController>(
            builder: (context, controller, _) {
              if (controller.isLoading) {
                return const CircularProgressIndicator(color: Colors.yellow);
              }
              return ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.blue,
                  onPrimary: Colors.blue,
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
                label: const Text('Entrar com Google',
                    style: TextStyle(color: Colors.black)),
              );
            },
          ),
        ],
      ),
    );
  }
}
