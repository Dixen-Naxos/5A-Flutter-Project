import 'package:cinqa_flutter_project/widgets/input_widgets/input_field.dart';
import 'package:cinqa_flutter_project/widgets/input_widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import 'button_widgets/button_widget.dart';
import 'home_page.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = "/logInPage";

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.connect) {
              Navigator.pop(context);
              MainPage.navigateTo(context);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.status == AuthStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == AuthStatus.error) {
                return const Center(
                  child: Text(
                    "T'es nul ahah",
                    style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                  ),
                );
              }
              if (state.status == AuthStatus.initial) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () => _onArrowBackClic(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              'Touiteur',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 50),
                      child: Center(
                        child: Text(
                          "Connexion",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 34),
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: InputField(
                              hintText: "Email",
                              controller: emailController,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: PasswordField(
                            controller: passwordController,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      child: ButtonWidget(
                        onTap: () => _onLogInClick(context),
                        text: "Se connecter",
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  void _onLogInClick(context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    authBloc.add(
      LogIn(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  void _onArrowBackClic(BuildContext context) {
    HomePage.navigateTo(context);
  }
}
