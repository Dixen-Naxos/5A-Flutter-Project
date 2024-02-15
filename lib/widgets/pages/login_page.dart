import 'package:cinqa_flutter_project/widgets/input_widgets/input_field.dart';
import 'package:cinqa_flutter_project/widgets/input_widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../button_widgets/button_widget.dart';
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
            final authBloc = BlocProvider.of<AuthBloc>(context);
            if (state.status == AuthStatus.connected) {
              print("LOgin");
              Navigator.pop(context);
              MainPage.navigateTo(context);
            }
            if (state.status == AuthStatus.error) {
              print(state.error!.response!.statusCode);
              print(state.error!.response!.data);
              switch (state.error!.response!.statusCode) {
                case 403:
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Je pense que ton email ou ton mot de passe est incorrect, reessaye victime (ne nous tapez pas svp c'est l'idée d'Arnaud Jourdain)",
                      ),
                    ),
                  );
                  break;
                case 400:
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Fais un effort et met un email valide pitié',
                      ),
                    ),
                  );
                  break;
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Quelque chose c'est mal passé",
                      ),
                    ),
                  );
                  break;
              }
              authBloc.add(
                Init(),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state.status == AuthStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == AuthStatus.initial) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        /*if (state.status == AuthStatus.error &&
                            state.error!.response!.statusCode == 403)
                          const AlertDialog(
                            content: Text(
                                "Le nom d'utilisateur ou le mot de passe est incorrect"),
                          ),*/
                        IconButton(
                          onPressed: () => _onArrowBackClic(context),
                          icon: const Icon(Icons.arrow_back),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Touiteur',
                              style: Theme.of(context).textTheme.titleLarge,
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
    print("Login");
    HomePage.navigateTo(context);
  }
}
