import 'package:cinqa_flutter_project/widgets/list_widgets/comments_list_widget.dart';
import 'package:cinqa_flutter_project/widgets/post_widgets/delete_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/detail_post_bloc/detail_post_bloc.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key, required this.postId});

  final int postId;
  static const String routeName = "/postDetailPage";

  static void navigateTo(BuildContext context, int postId) {
    Navigator.of(context).pushNamed(routeName, arguments: postId);
  }

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DetailPostBloc, DetailPostState>(
        listener: (context, detailPostState) {
          if (detailPostState.status == PostStatus.deleted) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: BlocBuilder<DetailPostBloc, DetailPostState>(
            builder: (context, state) {
              if (state.status == PostStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.status == PostStatus.success) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => _onArrowBackClic(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 20),
                                child: Text(
                                  state.post!.author!.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              DeleteButtonWidget(
                                post: state.post!,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 15),
                            child: Text(
                              state.post!.content,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          if (state.post?.image != null)
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight: 350,
                                    maxWidth: 350,
                                  ),
                                  child: Image.network(state.post!.image!.url),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (state.post?.comments != null)
                      CommentsListWidget(
                        comments: state.post!.comments!,
                        scrollController: _scrollController,
                      )
                  ],
                );
              }
              return const Placeholder();
            },
          ),
        ),
      ),
    );
  }

  void _onArrowBackClic(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void initState() {
    final postBloc = BlocProvider.of<DetailPostBloc>(context);
    postBloc.add(
      GetPost(postId: widget.postId),
    );
    super.initState();
  }
}
