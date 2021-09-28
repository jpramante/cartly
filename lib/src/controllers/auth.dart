import 'package:cartly/src/controllers/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends Controller {
  AuthController() {
    _signInSilently();
  }

  void _signInSilently() async {
    try {
      setStatus(Status.loading);
      _user = await googleSignIn.signInSilently();
      if (_user == null) setStatus(Status.success);
    } catch (e) {}
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future signInWithGoogle() async {
    try {
      setStatus(Status.loading);
      _user = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await _user?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    setStatus(Status.success);
  }

  signOut() async {
    setStatus(Status.loading);
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    setStatus(Status.success);
  }
}
