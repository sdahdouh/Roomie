import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:roomie/authentication/authentication_cubit.dart';
import 'package:roomie/authentication/authentication_state.dart';
import 'package:roomie/screens/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _signInFormkey = GlobalKey<FormState>();

  String _email;
  String _password;

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
                Form(
                  key: _signInFormkey,
                  child: Column(
                    children: [
                      TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field is required"),
                            EmailValidator(
                                errorText:
                                    "Please enter a valid e-mail address")
                          ]),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Enter your e-mail address'),
                          onSaved: (value) {
                            print("called");
                            _email = value;
                          }),
                      TextFormField(
                        validator: RequiredValidator(
                            errorText: "This field is required"),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter your Password'),
                        obscureText: true,
                        onSaved: (value) {
                          _password = value;
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_signInFormkey.currentState.validate()) {
                              _signInFormkey.currentState.save();

                              BlocProvider.of<AuthenticationCubit>(context)
                                  .signIn(
                                email: _email.trim(),
                                password: _password.trim(),
                              );
                            }
                          },
                          child: Text("Sign In"))
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider.value(
                            value: cubit, child: SignUpScreen());
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
