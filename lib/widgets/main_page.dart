import 'package:cinqa_flutter_project/widgets/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String routeName = "/mainPage";

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            UserPage.navigateTo(context, state.user!.id);
          }
        },
        child: SafeArea(
          child: IconButton(
            onPressed: () => _onHouseClic(context),
            icon: const Icon(
              Icons.house,
              color: Colors.purpleAccent,
            ),
          ),
        ),
      ),
    );
  }

  void _onHouseClic(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(
      Me(),
    );
  }
}
