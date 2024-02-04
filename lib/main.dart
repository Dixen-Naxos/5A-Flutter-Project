import 'package:cinqa_flutter_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:cinqa_flutter_project/widgets/home_page.dart';
import 'package:cinqa_flutter_project/widgets/login_page.dart';
import 'package:cinqa_flutter_project/widgets/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'datasources/api/auth_api/auth_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(
        authDataSource: AuthApi(),
      ),
      child: MaterialApp(
        routes: {
          '/': (context) => const HomePage(),
          SignupPage.routeName: (context) => BlocProvider(
              create: (context) => AuthBloc(
                    authRepository: context.read<AuthRepository>(),
                  ),
              child: const SignupPage()),
          LoginPage.routeName: (context) => BlocProvider(
              create: (context) => AuthBloc(
                    authRepository: context.read<AuthRepository>(),
                  ),
              child: const LoginPage()),
        },
        onGenerateRoute: (settings) {
          Widget content = const SizedBox();

          return MaterialPageRoute(builder: (context) => content);
        },
        title: "Touiteur",
      ),
    );
  }
}
