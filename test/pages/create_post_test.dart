import 'package:cinqa_flutter_project/blocs/all_post_bloc/all_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/theme_bloc/theme_bloc.dart';
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
import 'package:cinqa_flutter_project/widgets/input_widgets/input_field.dart';
import 'package:cinqa_flutter_project/widgets/pages/create_post_page.dart';
import 'package:cinqa_flutter_project/widgets/post_widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _setUpCreatePostPage(
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
        home: CreatePostPage(),
      ),
    ),
  );
}

void main() {
  group('$CreatePostPage', () {
    testWidgets('$CreatePostPage should display a back arrow icon',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpCreatePostPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('$CreatePostPage should display "Selectionnez une image" one time',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpCreatePostPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.text("Selectionnez une image"), findsOneWidget);
    });

    testWidgets('$CreatePostPage should display "Poster" one time',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpCreatePostPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.text("Poster"), findsOneWidget);
    });

    testWidgets('$CreatePostPage should display one Input field',
            (WidgetTester tester) async {
          await tester.pumpWidget(_setUpCreatePostPage(
            FakePostApi(),
            FakeUserApi(),
            FakeAuthApi(),
          ));
          await tester.pump(const Duration(seconds: 6));
          expect(find.byType(InputField), findsOneWidget);
        });
  });
}
