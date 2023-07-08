import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository( {FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<String> getCurrentUser() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      return user!.uid;
    } catch (e) {
      return "";
    }
  }
}
