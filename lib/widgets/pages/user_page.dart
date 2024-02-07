import 'package:cinqa_flutter_project/blocs/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/user_bloc/user_bloc.dart';
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
  late final _scrollController;
  final _scrollThreshold = 200.0;

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd/MM/yyyy');
    return Scaffold(
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
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Icon(
                                  Icons.account_circle,
                                  color: Colors.black,
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
                      const Divider(
                        color: Colors.redAccent,
                        thickness: 4,
                      ),
                      BlocBuilder<PostBloc, PostState>(
                        builder: (context, postState) {
                          if (postState.status == PostStatus.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (postState.status == PostStatus.success) {
                            return PostsListWidget(
                                scrollController: _scrollController,
                                posts: postState.posts!.items,
                                onScroll: () => _onScroll(
                                    postState.posts?.nextPage != null
                                        ? postState.posts!.nextPage
                                        : null),
                                user: userState.user);
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
    );
  }

  void _onArrowBackClic(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    final userBloc = BlocProvider.of<UserBloc>(context);
    final postBloc = BlocProvider.of<PostBloc>(context);
    _scrollController = ScrollController();
    userBloc.add(
      GetUser(userId: widget.userId),
    );

    postBloc.add(
      GetUserPosts(userId: widget.userId, page: 1, perPage: 100),
    );
  }

  void _onScroll(int? nextPage) async {
    if (nextPage == null || !_scrollController.hasClients) {
      print("bite");
      return;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final postBloc = BlocProvider.of<PostBloc>(context);
    if (maxScroll - currentScroll <= _scrollThreshold) {
      postBloc.add(
        GetMoreUserPosts(
          userId: widget.userId,
          page: nextPage,
          perPage: 100,
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
