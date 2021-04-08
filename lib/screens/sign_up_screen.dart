import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:roomie/authentication/authentication_cubit.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key key}) : super(key: key);

  GlobalKey<FormState> _signUpFormKey= GlobalKey<FormState>();

  String _email;
  String _password;
  String _passwordRepeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              TextFormField(
                validator: MultiValidator([
                  EmailValidator(
                      errorText: "Please enter a valid email address"),
                  RequiredValidator(errorText: "This field is required")
                ]),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Please enter your email address'),
                obscureText: false,
                onSaved: (String value) {
                  _email = value;
                },
              ),
              TextFormField(
                validator: MultiValidator([
                  MinLengthValidator(5,
                      errorText: 'Please enter atleast 5 chars'),
                  RequiredValidator(errorText: "This field is required"),
                ]),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Please enter a Password'),
                obscureText: true,
                onSaved: (String value) {
                  _password = value;
                },
              ),
              TextFormField(
                validator: (String input) =>
                    MatchValidator(errorText: 'The Passwords are not equal')
                        .validateMatch(_password, _passwordRepeat),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password repeat',
                    hintText: 'Please enter repeat the Password'),
                obscureText: true,
                onSaved: (String value) {
                  _passwordRepeat = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    print(_email);
                    print(_password);
                    print(_passwordRepeat);
                    if (_signUpFormKey.currentState.validate()) {
                      _signUpFormKey.currentState.save();

                      BlocProvider.of<AuthenticationCubit>(context).signUp(
                        email: _email.trim(),
                        password: _password.trim(),
                      );
                    }
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}
