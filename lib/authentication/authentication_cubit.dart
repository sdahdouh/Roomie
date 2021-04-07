import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomie/authentication/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth firebaseAuth;

  AuthenticationCubit({this.firebaseAuth}) : super(AuthenticationUnauthenticatedState()) {
    firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        emit(AuthenticationAuthenticatedState());
      } else {
        emit(AuthenticationUnauthenticatedState());
      }
    });
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signOut() async {
    try {
      await firebaseAuth.signOut();
      return "Signed Out";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
