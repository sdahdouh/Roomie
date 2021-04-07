import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationPendingState extends AuthenticationState {}

class AuthenticationUnauthenticatedState extends AuthenticationState {}

class AuthenticationAuthenticatedState extends AuthenticationState {
  final User user;

  AuthenticationAuthenticatedState({this.user});

  @override
  List<Object> get props => [user];
}
