import 'package:cinqa_flutter_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/user_repository.dart';
import 'package:cinqa_flutter_project/widgets/home_page.dart';
import 'package:cinqa_flutter_project/widgets/login_page.dart';
import 'package:cinqa_flutter_project/widgets/main_page.dart';
import 'package:cinqa_flutter_project/widgets/signup_page.dart';
import 'package:cinqa_flutter_project/widgets/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/user_bloc/user_bloc.dart';
import 'datasources/api/auth_api/auth_api.dart';
import 'datasources/api/user_api/user_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            authDataSource: AuthApi(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            userDataSource: UserApi(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            SignupPage.routeName: (context) => const SignupPage(),
            LoginPage.routeName: (context) => const LoginPage(),
            MainPage.routeName: (context) => const MainPage(),
          },
          onGenerateRoute: (settings) {
            Widget content = const SizedBox();

            switch (settings.name) {
              case UserPage.routeName:
                final arguments = settings.arguments;
                if (arguments is int) {
                  content = UserPage(userId: arguments);
                }
                break;
            }

            return MaterialPageRoute(builder: (context) => content);
          },
          title: "Touiteur",
        ),
      ),
    );
  }
}
