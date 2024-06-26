import 'package:cinqa_flutter_project/widgets/global_widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_post_bloc/user_post_bloc.dart';
import '../list_widgets/posts_list_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.userId});

  final int userId;
  static const String routeName = "/userPage";

  static void navigateTo(BuildContext context, int userId) {
    Navigator.of(context).pushNamed(routeName, arguments: userId);
  }

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final ScrollController _scrollController;
  final _scrollThreshold = 200.0;

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd/MM/yyyy');
    return BlocListener<UserPostBloc, UserPostState>(
      listener: (context, state) {
        if (state.status == UserPostStatus.error) {
          _showSnackBar(context);
        }
      },
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            if (userState.status == UserStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (userState.status == UserStatus.success) {
              return SafeArea(
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () => _onArrowBackClic(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: SizedBox(
                            height: 175,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: AvatarWidget(
                                    id: widget.userId,
                                    size: 75,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 20,
                                      runSpacing: 20,
                                      children: [
                                        Text(
                                          "Nom d'utilisateur : ${userState.user!.name}",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          style: const TextStyle(fontSize: 20),
                                          "Membre depuis le : ${f.format(DateTime.fromMillisecondsSinceEpoch(userState.user!.createdAt))}",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).colorScheme.onSurface,
                          thickness: 4,
                        ),
                        BlocBuilder<UserPostBloc, UserPostState>(
                          builder: (context, postState) {
                            if (postState.status == UserPostStatus.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (postState.status == UserPostStatus.success) {
                              if (postState.posts?.itemsReceived != 0) {
                                return PostsListWidget(
                                    onRefresh: _getPosts,
                                    scrollController: _scrollController,
                                    posts: postState.posts!.items,
                                    onScroll: () => _onScroll(
                                        postState.posts?.nextPage != null
                                            ? postState.posts!.nextPage
                                            : null),
                                    user: userState.user);
                              }
                              return Center(
                                child: Text(
                                  "Aucun post",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              );
                            }
                            return const Placeholder();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
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

  Future<void> _getPosts() async {
    final postBloc = BlocProvider.of<UserPostBloc>(context);
    postBloc.add(
      GetUserPosts(userId: widget.userId, page: 1, perPage: 50),
    );
  }

  @override
  void initState() {
    super.initState();
    final userBloc = BlocProvider.of<UserBloc>(context);
    final postBloc = BlocProvider.of<UserPostBloc>(context);
    _scrollController = ScrollController();
    userBloc.add(
      GetUser(userId: widget.userId),
    );

    postBloc.add(
      GetUserPosts(userId: widget.userId, page: 1, perPage: 50),
    );
  }

  void _onScroll(int? nextPage) async {
    if (nextPage == null || !_scrollController.hasClients) {
      return;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final postBloc = BlocProvider.of<UserPostBloc>(context);
    if (maxScroll - currentScroll <= _scrollThreshold) {
      postBloc.add(
        GetMoreUserPosts(
          userId: widget.userId,
          page: nextPage,
          perPage: 50,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Erreur lors du chargement des posts'),
      ),
    );
  }
}
