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
      );
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

  Future createUser(String userName, String email) async
  {
    return await FirebaseFirestore.instance.collection(FirestoreDB.instance.userCollection).doc(uid).set({
      FirestoreDB.instance.uid: uid,
      FirestoreDB.instance.username: userName,
      FirestoreDB.instance.userEmail: email,
    });
  }

  //get User doc stream
  Stream<User.User> get user => FirebaseFirestore.instance.collection(FirestoreDB.instance.userCollection).doc(uid).snapshots().map(_userFromSnapshot);

  //User from snapshot
  User.User _userFromSnapshot(DocumentSnapshot snapshot) => User.User.documentSnapshot(snapshot);
}