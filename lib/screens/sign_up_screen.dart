import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roomie/authentication/authentication_cubit.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
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
            TextField(
              controller: passwordRepeatController,
              decoration: InputDecoration(labelText: "Password repeat"),
            ),
            ElevatedButton(
                onPressed: () => {
                      if ((passwordController.text == passwordController.text) && emailController.text.isNotEmpty)
                        {
                          BlocProvider.of<AuthenticationCubit>(context).signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )
                        } else {
                        Text("Eingaben überprüfen!")
                      }
                    },
                child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}
