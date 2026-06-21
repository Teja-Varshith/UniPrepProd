import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uniprep/features/auth/auth_repository.dart';
import 'package:uniprep/model/user_model.dart';


final firebaseFirestoreProvider = Provider((ref)=>FirebaseFirestore.instance);


final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final userProvider = FutureProvider<UserModel?>((ref) async {
  final authState = ref.watch(authStateProvider);
  final fbUser = authState.value;
  if (fbUser == null) return null;

  final doc = await ref.watch(firebaseFirestoreProvider)
      .collection('users')
      .doc(fbUser.uid)
      .get();

  return doc.exists ? UserModel.fromMap(doc.data()!) : null;
});