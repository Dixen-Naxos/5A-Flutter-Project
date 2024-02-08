import 'package:cinqa_flutter_project/blocs/all_post_bloc/all_post_bloc.dart';
import 'package:cinqa_flutter_project/widgets/button_widgets/new_post_button_widget.dart';
import 'package:cinqa_flutter_project/widgets/list_widgets/posts_list_widget.dart';
import 'package:cinqa_flutter_project/widgets/pages/home_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
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
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
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
        child: SafeArea(
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
                              icon: const Icon(
                                Icons.house,
                                color: Colors.purpleAccent,
                              ),
                            ),
                          Expanded(
                            child: Container(),
                          ),
                          state.status == AuthStatus.connect
                              ? IconButton(
                                  onPressed: () => _onDisconnectClic(context),
                                  icon: const Icon(
                                    Icons.exit_to_app,
                                    color: Colors.black,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () => _onConnectClic(context),
                                  icon: const Icon(
                                    Icons.accessible,
                                    color: Colors.black,
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
                            return const Center(
                              child: Text("Aucun post"),
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
      ),
      floatingActionButton: NewPostButtonWidget(
        onFloatingButtonPressed: _onFloatingButtonPressed,
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
}
