import 'package:cinqa_flutter_project/widgets/input_widgets/input_field.dart';
import 'package:cinqa_flutter_project/widgets/input_widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import 'button_widgets/button_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const String routeName = "/signUpPage";

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        "Créer un compte",
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: PasswordField(
                          controller: passwordController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 50,
                        ),
                        child: InputField(
                          hintText: "Nom",
                          controller: nameController,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ButtonWidget(
                      onTap: () => _onCreateAccountClic(context),
                      text: "Créer un compte",
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _onArrowBackClic(BuildContext context) {
    Navigator.pop(context);
  }

  void _onCreateAccountClic(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    authBloc.add(
      SignUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }
}
