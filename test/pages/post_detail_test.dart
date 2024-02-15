import 'package:cinqa_flutter_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:cinqa_flutter_project/blocs/comment_bloc/comment_bloc.dart';
import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/all_post_bloc/all_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/theme_bloc/theme_bloc.dart';
import 'package:cinqa_flutter_project/blocs/user_bloc/user_bloc.dart';
import 'package:cinqa_flutter_project/datasources/api/auth_api/error_auth_api.dart';
import 'package:cinqa_flutter_project/datasources/api/auth_api/fake_auth_api.dart';
import 'package:cinqa_flutter_project/datasources/api/comment_api/fake_comment_api.dart';
import 'package:cinqa_flutter_project/datasources/api/post_api/fake_post_api.dart';
import 'package:cinqa_flutter_project/datasources/api/post_api/fake_post_api_without_comment.dart';
import 'package:cinqa_flutter_project/datasources/api/user_api/fake_user_api.dart';
import 'package:cinqa_flutter_project/datasources/datasources/auth_datasource.dart';
import 'package:cinqa_flutter_project/datasources/datasources/comment_datasource.dart';
import 'package:cinqa_flutter_project/datasources/datasources/post_datasource.dart';
import 'package:cinqa_flutter_project/datasources/datasources/user_datasource.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/comment_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/post_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/user_repository.dart';
import 'package:cinqa_flutter_project/widgets/comment_widgets/comment_widget.dart';
import 'package:cinqa_flutter_project/widgets/pages/post_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _setUpPostDetailPage(
  PostDataSource postDataSource,
  UserDataSource userDatasource,
  AuthDataSource authDataSource,
  CommentDataSource commentDataSource,
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
      RepositoryProvider(
        create: (context) => CommentRepository(
          commentDataSource: commentDataSource,
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
          create: (context) => DetailPostBloc(
            postRepository: context.read<PostRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => CommentBloc(
            commentRepository: context.read<CommentRepository>(),
          ),
        )
      ],
      child: const MaterialApp(
        home: PostDetailPage(postId: 1),
      ),
    ),
  );
}

void main() {
  group('$PostDetailPage', () {
    testWidgets('$PostDetailPage should display a pseudo',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostDetailPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
        FakeCommentApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.text("Dixen"), findsAtLeastNWidgets(1));
    });

    testWidgets('$PostDetailPage should display a message',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostDetailPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
        FakeCommentApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.text("Not patched"), findsOneWidget);
    });

    testWidgets('$PostDetailPage should display at least one comment',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostDetailPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
        FakeCommentApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.byType(CommentWidget), findsAtLeastNWidgets(1));
    });

    testWidgets('$PostDetailPage shouldnt display any comment',
            (WidgetTester tester) async {
          await tester.pumpWidget(_setUpPostDetailPage(
            FakePostApiWithoutComment(),
            FakeUserApi(),
            FakeAuthApi(),
            FakeCommentApi(),
          ));
          await tester.pump(const Duration(seconds: 6));
          expect(find.byType(CommentWidget), findsNothing);
        });

    testWidgets('$PostDetailPage should display "Aucun commentaire"',
            (WidgetTester tester) async {
          await tester.pumpWidget(_setUpPostDetailPage(
            FakePostApiWithoutComment(),
            FakeUserApi(),
            FakeAuthApi(),
            FakeCommentApi(),
          ));
          await tester.pump(const Duration(seconds: 6));
          expect(find.text("Aucun commentaire"), findsOneWidget);
        });

    testWidgets('$PostDetailPage should display edit and trash icon when author is auth',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostDetailPage(
        FakePostApi(),
        FakeUserApi(),
        FakeAuthApi(),
        FakeCommentApi(),
      ));
      await tester.pump(const Duration(seconds: 20));
      expect(find.byType(IconButton), findsAtLeastNWidgets(2));
      await tester.pumpAndSettle();
    });

    testWidgets(
        '$PostDetailPage should not display trash icon when author is not auth',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostDetailPage(
        FakePostApi(),
        FakeUserApi(),
        ErrorAuthApi(),
        FakeCommentApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.byIcon(Icons.delete), findsNothing);
      await tester.pumpAndSettle();
    });

    testWidgets(
        '$PostDetailPage should not display edit icon when author is not auth',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostDetailPage(
        FakePostApi(),
        FakeUserApi(),
        ErrorAuthApi(),
        FakeCommentApi(),
      ));
      await tester.pump(const Duration(seconds: 6));
      expect(find.byIcon(Icons.edit), findsNothing);
      await tester.pumpAndSettle();
    });

    testWidgets(
        '$PostDetailPage should display circular progress indicator when loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostDetailPage(
        FakePostApi(),
        FakeUserApi(),
        ErrorAuthApi(),
        FakeCommentApi(),
      ));
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });

    testWidgets(
        '$PostDetailPage should hide circular progress indicator when loading end',
        (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostDetailPage(
        FakePostApi(),
        FakeUserApi(),
        ErrorAuthApi(),
        FakeCommentApi(),
      ));
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(seconds: 6));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets(
        '$PostDetailPage should hide circular progress indicator when loading end',
            (WidgetTester tester) async {
          await tester.pumpWidget(_setUpPostDetailPage(
            FakePostApi(),
            FakeUserApi(),
            ErrorAuthApi(),
            FakeCommentApi(),
          ));
          await tester.pump(const Duration(seconds: 3));
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          await tester.pump(const Duration(seconds: 6));
          expect(find.byType(CircularProgressIndicator), findsNothing);
        });
  });
}
