import 'package:cinqa_flutter_project/widgets/button_widgets/button_widget.dart';
import 'package:cinqa_flutter_project/widgets/pages/login_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/signup_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = "/homePage";

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "Touiteur",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Decouvrez absolument rien en temps réel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ButtonWidget(
                      onTap: () => _onLogInClick(context),
                      text: "Se connecter",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).dividerColor,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "ou",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).dividerColor,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ButtonWidget(
                      onTap: () => _onSignUpClick(context),
                      text: "Créer un compte",
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onSignUpClick(BuildContext context) {
    Navigator.pop(context);
    SignupPage.navigateTo(context);
  }

  void _onLogInClick(BuildContext context) {
    Navigator.pop(context);
    LoginPage.navigateTo(context);
  }

/*@override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(
      Me(),
    );
  }*/
}
