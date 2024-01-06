import 'package:cinqa_flutter_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:cinqa_flutter_project/widgets/home_page.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>()))
        ],
        child: const HomePage(),
      ),
    );
  }
}
