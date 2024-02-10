import 'dart:io';

import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:cinqa_flutter_project/widgets/input_widgets/input_field.dart';
import 'package:cinqa_flutter_project/widgets/pages/post_detail_page.dart';
import 'package:cinqa_flutter_project/widgets/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/all_post_bloc/all_post_bloc.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/user_post_bloc/user_post_bloc.dart';
import '../../models/post.dart';
import '../../models/user.dart';
import '../global_widgets/avatar_widget.dart';
import 'delete_button_widget.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.post, this.user});

  final Post post;

  final User? user;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isEditing = false;
  TextEditingController contentController = TextEditingController();
  File? image;

  //User? realUser = widget.user ?? widget.post.author;

  @override
  Widget build(BuildContext context) {
    User? realUser = widget.user ?? widget.post.author;

    final timeSincePost = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(widget.post.createdAt));
    return BlocListener<DetailPostBloc, DetailPostState>(
      listener: (context, state) {
        if (state.status == DetailPostStatus.patched) {
          final allPostBloc = BlocProvider.of<AllPostBloc>(context);
          allPostBloc.add(
            AllPatchPost(
              post: state.post!,
            ),
          );

          final userPostBloc = BlocProvider.of<UserPostBloc>(context);
          userPostBloc.add(
            UserPatchPost(
              post: state.post!,
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () => _onPostTap(context),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*GestureDetector(
                  onTap: () => _onProfileTap(context, realUser!.id),
                  child: AvatarWidget(
                    id: realUser!.id,
                    size: 50,
                  ),
                ),*/
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: GestureDetector(
                            onTap: () => _onProfileTap(context, realUser!.id),
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, authState) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: AvatarWidget(
                                        id: realUser!.id,
                                        size: 50,
                                      ),
                                    ),
                                    Text(
                                      realUser.name,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        timeSincePost.inDays > 0
                                            ? "${timeSincePost.inDays}j"
                                            : timeSincePost.inHours > 0
                                                ? "${timeSincePost.inHours}h"
                                                : timeSincePost.inMinutes > 0
                                                    ? "${timeSincePost.inMinutes}m"
                                                    : "${timeSincePost.inSeconds}s",
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    if (authState.user?.id == realUser.id)
                                      isEditing == false
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isEditing = true;
                                                  contentController.text =
                                                      widget.post.content;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isEditing = false;
                                                  image = null;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.cancel,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                    if (authState.user?.id == realUser.id)
                                      isEditing == false
                                          ? DeleteButtonWidget(
                                              post: widget.post,
                                            )
                                          : IconButton(
                                              onPressed: _onSave,
                                              icon: Icon(
                                                Icons.save,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 20, top: 5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 75,
                            child: !isEditing
                                ? Text(
                                    widget.post.content,
                                  )
                                : InputField(
                                    hintText: "Ecrivez ici...",
                                    controller: contentController,
                                    multiline: true,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.post.image != null && image == null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxHeight: 200,
                                      maxWidth: 200,
                                    ),
                                    child:
                                        Image.network(widget.post.image!.url),
                                  ),
                                ),
                              if (image != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxHeight: 200,
                                      maxWidth: 200,
                                    ),
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
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.comment,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ),
                            Text(
                              "${widget.post.commentCounts == 0 || widget.post.commentCounts == null ? "Aucun commentaire" : widget.post.commentCounts}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPostTap(BuildContext context) {
    PostDetailPage.navigateTo(context, widget.post.id);
  }

  void _onProfileTap(BuildContext context, int userId) {
    if (widget.user == null) UserPage.navigateTo(context, userId);
  }

  void _onSave() {
    final detailPostBloc = BlocProvider.of<DetailPostBloc>(context);

    detailPostBloc.add(
      PatchPost(
        image: image,
        content: contentController.text,
        id: widget.post.id,
      ),
    );
    isEditing = false;
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
