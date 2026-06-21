import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_snackbar/flutter_awesome_snackbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uniprep/app/provider.dart';
import 'package:uniprep/model/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    auth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firebaseFirestoreProvider),
    signIn: ref.read(googleSignInProvider),
  );
});

final authStateProvider = StreamProvider<User?>((ref) { 
  return ref.read(authRepositoryProvider).authStateChanges;
  }
  );


 

class AuthRepository{
    final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required GoogleSignIn signIn,
  })  :  _auth = auth,
        _firestore = firestore,
        _googleSignIn = signIn;




  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async{
    print('signout');
    await _googleSignIn.signOut();
    await _auth.signOut();
  }


  
  Future<UserModel?> signInWithGoogle() async{
    try{

      AwesomeSnackbar.info('happening');
      print('startrr');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();      
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userMeta = (await _auth.signInWithCredential(credential)).user;

      if (userMeta == null) {
        // _showErrorSnackBar('Sign in failed. Please try again.');
        return null;
      }

      final user = UserModel(
        name: userMeta.displayName?? '',
        id: userMeta.uid,
        profileComplete: false,
        emailId: userMeta.email?? '',
        coins: 0,
        hasAdFreeAccess: false,
      );

     final doc = await _firestore
    .collection('users')
    .doc(user.id)
    .get();

if (doc.exists) {
  return UserModel.fromMap(doc.data()!);
}

await _firestore
    .collection('users')
    .doc(user.id)
    .set(user.toMap());


return user;
    }catch(e){
      print("eeee" + e.toString());
      AwesomeSnackbar.error(e.toString());

    }
    return null;
  }
    
}