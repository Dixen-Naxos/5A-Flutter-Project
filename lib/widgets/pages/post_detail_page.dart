import 'dart:io';

import 'package:cinqa_flutter_project/widgets/list_widgets/comments_list_widget.dart';
import 'package:cinqa_flutter_project/widgets/post_widgets/delete_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/detail_post_bloc/detail_post_bloc.dart';
import '../input_widgets/input_field.dart';

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
  bool isEditing = false;
  TextEditingController contentController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DetailPostBloc, DetailPostState>(
        listener: (context, detailPostState) {
          if (detailPostState.status == DetailPostStatus.deletedFromDetail) {
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: BlocBuilder<DetailPostBloc, DetailPostState>(
            builder: (context, detailPostState) {
              if (detailPostState.status == DetailPostStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (detailPostState.status == DetailPostStatus.success ||
                  detailPostState.status == DetailPostStatus.patched) {
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
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
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 20),
                                    child: Text(
                                      detailPostState.post!.author!.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  if (authState.user?.id ==
                                      detailPostState.post!.author!.id)
                                    isEditing == false
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isEditing = true;
                                                contentController.text =
                                                    detailPostState
                                                        .post!.content;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isEditing = false;
                                                image = null;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: Colors.black,
                                            ),
                                          ),
                                  if (authState.user?.id ==
                                      detailPostState.post!.author!.id)
                                    isEditing == false
                                        ? DeleteButtonWidget(
                                            post: detailPostState.post!,
                                          )
                                        : IconButton(
                                            onPressed: _onSave,
                                            icon: const Icon(
                                              Icons.save,
                                              color: Colors.black,
                                            ),
                                          ),
                                ],
                              ),
                              !isEditing
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 15),
                                      child: Text(
                                        detailPostState.post!.content,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    )
                                  : InputField(
                                      hintText: "Ecrivez ici...",
                                      controller: contentController,
                                      multiline: true,
                                    ),
                              if (detailPostState.post?.image != null)
                                Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (detailPostState.post!.image !=
                                                  null &&
                                              image == null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxHeight: 350,
                                                        maxWidth: 300),
                                                child: Image.network(
                                                    detailPostState
                                                        .post!.image!.url),
                                              ),
                                            ),
                                          if (image != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ConstrainedBox(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxHeight: 350,
                                                        maxWidth: 300),
                                                child: Image.file(image!),
                                              ),
                                            ),
                                          if (isEditing)
                                            IconButton(
                                              onPressed: _onOpenImage,
                                              icon: const Icon(Icons.link),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (detailPostState.post?.comments != null &&
                            !isEditing)
                          CommentsListWidget(
                            comments: detailPostState.post!.comments!,
                            scrollController: _scrollController,
                          )
                      ],
                    );
                  },
                );
              }
              return Container();
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

  void _onSave() {
    final detailPostBloc = BlocProvider.of<DetailPostBloc>(context);

    detailPostBloc.add(
      PatchPost(
        image: image,
        content: contentController.text,
        id: detailPostBloc.state.post!.id,
      ),
    );
    isEditing = false;
    detailPostBloc.add(
      GetPost(postId: widget.postId),
    );
  }

  void _onOpenImage() async {
    try {
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (imagePicker == null) return;
      setState(() {
        image = File(imagePicker.path);
      });
    } catch (e) {
      print(e);
    }
  }
}
