import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _userCollection;

  SignUpRepository(
      {FirebaseAuth? firebaseAuth, CollectionReference? userCollection})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _userCollection =
            userCollection ?? FirebaseFirestore.instance.collection('users');

  Future<String> signUpWithCredential(
      {required String email, required String password}) async {
    String userId = '';
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      userId = userCredential.user!.uid;
    } catch (_) {
      userId = '';
    }
    return userId;
  }

  Future<bool> addUser({required Map<String, dynamic> user}) async {
    bool isSet = false;
    try{
     await _userCollection.doc(user['userId']).set({user});
      isSet = true;
    }catch(_){
      isSet = false;
    }
    return isSet;
  }
}
