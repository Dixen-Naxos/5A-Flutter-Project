import 'package:cinqa_flutter_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/theme_bloc/theme_bloc.dart';
import 'package:cinqa_flutter_project/datasources/api/comment_api/comment_api.dart';
import 'package:cinqa_flutter_project/datasources/repository/auth_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/comment_repository.dart';
import 'package:cinqa_flutter_project/datasources/repository/user_repository.dart';
import 'package:cinqa_flutter_project/widgets/pages/create_post_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/home_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/login_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/main_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/post_detail_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/signup_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/all_post_bloc/all_post_bloc.dart';
import 'blocs/comment_bloc/comment_bloc.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'blocs/user_post_bloc/user_post_bloc.dart';
import 'datasources/api/auth_api/auth_api.dart';
import 'datasources/api/post_api/post_api.dart';
import 'datasources/api/user_api/user_api.dart';
import 'datasources/repository/post_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            authDataSource: AuthApi(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            userDataSource: UserApi(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PostRepository(
            postDataSource: PostApi(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CommentRepository(
            commentDataSource: CommentApi(),
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
            create: (context) => UserPostBloc(
              postRepository: context.read<PostRepository>(),
            ),
          ),
          BlocProvider(create: (context) => ThemeBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              theme: themeState.theme,
              routes: {
                HomePage.routeName: (context) => const HomePage(),
                SignupPage.routeName: (context) => const SignupPage(),
                LoginPage.routeName: (context) => const LoginPage(),
                MainPage.routeName: (context) => const MainPage(),
                CreatePostPage.routeName: (context) => const CreatePostPage(),
              },
              onGenerateRoute: (settings) {
                Widget content = const SizedBox();

                switch (settings.name) {
                  case PostDetailPage.routeName:
                    final arguments = settings.arguments;
                    if (arguments is int) {
                      content = BlocProvider(
                        create: (context) => CommentBloc(
                          commentRepository: context.read<CommentRepository>(),
                        ),
                        child: PostDetailPage(postId: arguments),
                      );
                    }
                    break;
                  case UserPage.routeName:
                    final arguments = settings.arguments;
                    if (arguments is int) {
                      content = UserPage(userId: arguments);
                    }
                    break;
                }

                return MaterialPageRoute(builder: (context) => content);
              },
              title: "Touiteur",
            );
          },
        ),
      ),
    );
  }
}
