import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:roomie/authentication/authentication_cubit.dart';
import 'package:roomie/authentication/authentication_state.dart';
import 'package:roomie/screens/hompageScreen.dart';
import 'package:roomie/screens/signUpScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      );
  }
}
class  MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      BlocProvider(create: (_) => AuthenticationCubit(firebaseAuth: FirebaseAuth.instance)),
    ],
    child: AuthenticationWrapper() ,);
  }
}


class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      cubit: BlocProvider.of<AuthenticationCubit>(context),
      builder: (context, state) {
        if (state is AuthenticationAuthenticatedState) {
          return HomepageScreen(
            authenticatedState: state,
          );
        }
        return SignInScreen();
      },
    );
  }
}




