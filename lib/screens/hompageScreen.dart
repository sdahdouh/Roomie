import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomie/authentication/authentication_cubit.dart';
import 'package:roomie/authentication/authentication_state.dart';

class HomepageScreen extends StatelessWidget {
  final AuthenticationAuthenticatedState authenticatedState;

 HomepageScreen({Key key, this.authenticatedState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("Welcome"),
            ElevatedButton(onPressed: () {
              BlocProvider.of<AuthenticationCubit>(context).signOut();
            }, child: Text("SignOut"))
          ],
        ),
      ),
    );
  }
}
