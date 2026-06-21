import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:uniprep/app/provider.dart';
import 'package:uniprep/features/auth/auth_repository.dart';
import 'package:uniprep/model/user_model.dart';


final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    ref.read(authRepositoryProvider),
    ref
  );
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repository;
  final Ref ref;

  AuthController(this._repository,this.ref) : super(false);

  Future<UserModel?> signInWithGoogle() async {
    state = true;

    try {
      print('start');
      return await _repository.signInWithGoogle();
    } finally {
      state = false;
    }
  }

  Future<void> signOut() async {
    state = true;

    try {
      await _repository.signOut();
    } finally {
      state = false;
    }
  }
}