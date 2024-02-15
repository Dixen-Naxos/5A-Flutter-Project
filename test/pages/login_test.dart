import 'package:cinqa_flutter_project/blocs/all_post_bloc/all_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/theme_bloc/theme_bloc.dart';
import 'package:cinqa_flutter_project/blocs/user_bloc/user_bloc.dart';
import 'package:cinqa_flutter_project/datasources/api/auth_api/fake_auth_api.dart';
import 'package:cinqa_flutter_project/datasources/api/post_api/fake_post_api.dart';
import 'package:cinqa_flutter_project/datasources/api/user_api/fake_user_api.dart';
import 'package:cinqa_flutter_project/datasources/datasources/auth_datasource.dart';
import 'package:cinqa_flutter_project/datasources/datasources/post_datasource.dart';
import 'package:cinqa_flutter_project/datasources/datasources/user_datasource.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/post_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/user_repository.dart';
import 'package:cinqa_flutter_project/widgets/button_widgets/button_widget.dart';
import 'package:cinqa_flutter_project/widgets/input_widgets/input_field.dart';
import 'package:cinqa_flutter_project/widgets/input_widgets/password_field.dart';
import 'package:cinqa_flutter_project/widgets/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _setUpLoginPage(
  PostDataSource postDataSource,
  UserDataSource userDatasource,
  AuthDataSource authDataSource,
) {
  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => AuthRepository(
          authDataSource: authDataSource,
        ),
      ),
      RepositoryProvider(
        create: (context) => UserRepository(
          userDataSource: userDatasource,
        ),
      ),
      RepositoryProvider(
        create: (context) => PostRepository(
          postDataSource: postDataSource,
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
        BlocProvider(
          create: (context) => DetailPostBloc(
            postRepository: context.read<PostRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AllPostBloc(
            postRepository: context.read<PostRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: const MaterialApp(
        home: LoginPage(),
      ),
    ),
  );
}

void main() {
  group('$LoginPage', () {
    testWidgets('$LoginPage should display the right title',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpLoginPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));

      expect(find.text("Touiteur"), findsOneWidget);
    });

    testWidgets('$LoginPage should display the right text',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpLoginPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.text("Se connecter"), findsWidgets);
    });

    testWidgets('$LoginPage should display two input fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpLoginPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.text("Email"), findsOneWidget);
    });

    testWidgets('$LoginPage should display the password input field',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpLoginPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.text("Mot de passe"), findsOneWidget);
    });

    testWidgets('$LoginPage should display the right login button',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpLoginPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.widgetWithText(ButtonWidget, "Se connecter"), findsOneWidget);
    });

    testWidgets('$LoginPage shouldnt display a snackbar',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpLoginPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      await tester.enterText(
          find.widgetWithText(InputField, "Email"), "texttext@example.com");
      await tester.enterText(
          find.widgetWithText(PasswordField, "Mot de passe"), "texttext");
      await tester.tap(find.widgetWithText(ButtonWidget, "Se connecter"));
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(SnackBar), findsNothing);
    });
  });
}
