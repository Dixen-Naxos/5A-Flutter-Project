import 'package:cinqa_flutter_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/all_post_bloc/all_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/user_bloc/user_bloc.dart';
import 'package:cinqa_flutter_project/datasources/api/auth_api/error_auth_api.dart';
import 'package:cinqa_flutter_project/datasources/api/auth_api/fake_auth_api.dart';
import 'package:cinqa_flutter_project/datasources/api/post_api/fake_post_api.dart';
import 'package:cinqa_flutter_project/datasources/api/user_api/fake_user_api.dart';
import 'package:cinqa_flutter_project/datasources/datasources/auth_datasource.dart';
import 'package:cinqa_flutter_project/datasources/datasources/post_datasource.dart';
import 'package:cinqa_flutter_project/datasources/datasources/user_datasource.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/post_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/user_repository.dart';
import 'package:cinqa_flutter_project/widgets/pages/main_page.dart';
import 'package:cinqa_flutter_project/widgets/post_widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _setUpMainPage(
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
      ],
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}

void main() {
  group('$MainPage', () {
    testWidgets('$MainPage should display an house icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpMainPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.byIcon(Icons.house), findsOneWidget);
    });

    testWidgets('$MainPage shouldnt display a house icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpMainPage(
        FakePostApi(),
        FakeUserApi(),
        ErrorAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.byIcon(Icons.house), findsNothing);
    });

    /// Ne passe pas car état vide non géré.
    //testWidgets('$MainPage should display an error if an error occurred',
    //    (WidgetTester tester) async {
    //  await tester.pumpWidget(_setUpMainPage(
    //    ErrorPostApi(),
    //    ErrorUserApi(),
    //    ErrorAuthApi(),
    //  ));
    //  await tester.pump(const Duration(seconds: 3));
    //  expect(find.text('Oups, une erreur est survenue.'), findsOneWidget);
    //});

    testWidgets('$MainPage should display a loading indicator',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpMainPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    /// Ne passe pas car état vide non géré.
    // testWidgets('$ProductsScreen should display a specific message when empty result', (WidgetTester tester) async {
    //   await tester.pumpWidget(_setUpProductsScreen(EmptyDataSource()));
    //   await tester.pump(const Duration(seconds: 3));
    //   expect(find.text('Aucun produit'), findsOneWidget);
    // });

    testWidgets('$MainPage should display a loader when Loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpMainPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets('$MainPage should display at least a post',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpMainPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 7));
      expect(find.byType(PostWidget), findsAtLeastNWidgets(1));
    });

    testWidgets('$MainPage should display trash icon when author is auth',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpMainPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.byIcon(Icons.delete), findsAtLeastNWidgets(1));
    });

    testWidgets(
        '$MainPage should not display trash icon when author is not auth',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpMainPage(
        FakePostApi(),
        FakeUserApi(),
        ErrorAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.byIcon(Icons.delete), findsNothing);
    });

    testWidgets('$MainPage should display edit icon when author is auth',
            (WidgetTester tester) async {
          await tester.pumpWidget(_setUpMainPage(
            FakePostApi(),
            FakeUserApi(),
            FakeAuthApi(),
          ));
          await tester.pump(const Duration(seconds: 7));
          expect(find.byIcon(Icons.edit), findsAtLeastNWidgets(1));
        });

    testWidgets(
        '$MainPage should not display edit icon when author is not auth',
            (WidgetTester tester) async {
          await tester.pumpWidget(_setUpMainPage(
            FakePostApi(),
            FakeUserApi(),
            ErrorAuthApi(),
          ));
          await tester.pump(const Duration(seconds: 6));
          expect(find.byIcon(Icons.edit), findsNothing);
        });
  });
}
