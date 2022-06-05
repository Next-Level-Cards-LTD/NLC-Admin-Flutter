part of 'package:next_level_admin/Shared/Libraries/Database_Library.dart';


class Authentication {
  final Auth.FirebaseAuth _auth = Auth.FirebaseAuth.instance;

  //Pages.Auth Change User Stream
  Stream<Auth.User?> get currentUser => Auth.FirebaseAuth.instance.authStateChanges();

  //Sign In Email and Password
  Future signInEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => User.User.setup(value.user!.uid));
    } on Auth.FirebaseAuthException catch (e) {
      SignInErrors.show(e.code);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signOut() async {
    _auth.signOut();
  }

  Future createUser(User.User user) async => await FirebaseFirestore.instance.collection(userCollection).doc(uid).set(user.toMap());
}