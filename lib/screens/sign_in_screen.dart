import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomie/authentication/authentication_cubit.dart';
import 'package:roomie/authentication/authentication_state.dart';
import 'package:roomie/screens/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<AuthenticationCubit>(context);
          return Center(
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationCubit>(context).signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  },
                  child: Text("Sign In"),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return BlocProvider.value(value: cubit, child: SignUpScreen());
                      }));
                    },
                    child: Text("Sign Up"))
              ],
            ),
          );
        },
      ),
    );
  }
}
