import 'package:cinqa_flutter_project/blocs/all_post_bloc/all_post_bloc.dart';
import 'package:cinqa_flutter_project/widgets/button_widgets/button_widget.dart';
import 'package:cinqa_flutter_project/widgets/button_widgets/new_post_button_widget.dart';
import 'package:cinqa_flutter_project/widgets/list_widgets/posts_list_widget.dart';
import 'package:cinqa_flutter_project/widgets/pages/home_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/theme_bloc/theme_bloc.dart';
import '../../models/user.dart';
import 'create_post_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String routeName = "/";

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  User? user;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.disconnected) {
              Navigator.pop(context);
              HomePage.navigateTo(context);
              final authBloc = BlocProvider.of<AuthBloc>(context);
              authBloc.add(
                Init(),
              );
            }
            if (state.status == AuthStatus.success) {
              UserPage.navigateTo(context, state.user!.id);
            }
            if (state.status == AuthStatus.error) {
              HomePage.navigateTo(context);
            }
          },
        ),
        BlocListener<AllPostBloc, AllPostState>(
          listener: (context, state) {
            if (state.status == AllPostStatus.error) {
              _showSnackBar(context);
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.status == AuthStatus.connect)
                            IconButton(
                              onPressed: () =>
                                  _onHouseClic(context, state.user!.id),
                              icon: Icon(
                                Icons.house,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          Expanded(
                            child: Container(),
                          ),
                          IconButton(
                            icon: _getThemeIcon(),
                            onPressed: _toggleColorTheme,
                            color: Theme.of(context).hintColor,
                          ),
                          state.status == AuthStatus.connect
                              ? IconButton(
                                  onPressed: () => _onDisconnectClic(context),
                                  icon: Icon(
                                    Icons.exit_to_app,
                                    color: Theme.of(context).hintColor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () => _onConnectClic(context),
                                  icon: Icon(
                                    Icons.accessible,
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                ),
                        ],
                      ),
                      BlocBuilder<AllPostBloc, AllPostState>(
                        builder: (context, postState) {
                          if (postState.status == AllPostStatus.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (postState.status == AllPostStatus.success) {
                            if (postState.posts?.itemsReceived != 0) {
                              return PostsListWidget(
                                onRefresh: _getPosts,
                                scrollController: _scrollController,
                                posts: postState.posts!.items,
                                onScroll: () => _onScroll(
                                    postState.posts?.nextPage != null
                                        ? postState.posts!.nextPage
                                        : null),
                              );
                            }
                            return Center(
                              child: Text(
                                "Aucun post",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: NewPostButtonWidget(
          onFloatingButtonPressed: _onFloatingButtonPressed,
        ),
      ),
    );
  }

  void _onHouseClic(BuildContext context, int userId) {
    UserPage.navigateTo(context, userId);
  }

  void _onDisconnectClic(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(
      Disconnect(),
    );
  }

  void _onConnectClic(BuildContext context) {
    HomePage.navigateTo(context);
  }

  Future<void> _getPosts() async {
    final postBloc = BlocProvider.of<AllPostBloc>(context);
    postBloc.add(
      GetPosts(page: 1, perPage: 15),
    );
  }

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(
      Connect(),
    );
    _getPosts();
  }

  void _onScroll(int? nextPage) async {
    if (nextPage == null) {
      return;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final postBloc = BlocProvider.of<AllPostBloc>(context);
    if (maxScroll - currentScroll <= _scrollThreshold &&
        !postBloc.state.scrollLoading) {
      postBloc.add(
        GetMorePosts(
          page: nextPage,
          perPage: 15,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onFloatingButtonPressed() {
    CreatePostPage.navigateTo(context);
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Erreur lors du chargement des posts'),
      ),
    );
  }

  void _toggleColorTheme() {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(
      SetTheme(
        theme: themeBloc.state.theme == ThemeData.light()
            ? ThemeData.dark()
            : ThemeData.light(),
      ),
    );
  }

  Widget _getThemeIcon() {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return themeBloc.state.theme == ThemeData.light()
        ? const Icon(Icons.sunny)
        : const Icon(Icons.nightlight_outlined);
  }
}
