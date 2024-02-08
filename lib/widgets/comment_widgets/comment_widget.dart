import 'package:cinqa_flutter_project/widgets/global_widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/comment_bloc/comment_bloc.dart';
import '../../models/comment.dart';
import '../input_widgets/input_field.dart';
import '../pages/user_page.dart';
import 'delete_button_widget.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key, required this.comment});

  final Comment comment;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool isEditing = false;

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final timeSinceComment = DateTime.now().difference(
        DateTime.fromMillisecondsSinceEpoch(widget.comment.createdAt));
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _onProfileTap(context, widget.comment.author!.id),
              child: AvatarWidget(
                id: widget.comment.author!.id,
                size: 50,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () =>
                          _onProfileTap(context, widget.comment.author!.id),
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, authState) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.comment.author!.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  style: Theme.of(context).textTheme.bodySmall,
                                  timeSinceComment.inDays > 0
                                      ? "${timeSinceComment.inDays}j"
                                      : timeSinceComment.inHours > 0
                                          ? "${timeSinceComment.inHours}h"
                                          : timeSinceComment.inMinutes > 0
                                              ? "${timeSinceComment.inMinutes}m"
                                              : "${timeSinceComment.inSeconds}s",
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              if (authState.user?.id ==
                                  widget.comment.author!.id)
                                isEditing == false
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isEditing = true;
                                            contentController.text =
                                                widget.comment.content;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isEditing = false;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                              if (authState.user?.id ==
                                  widget.comment.author!.id)
                                isEditing == false
                                    ? DeleteButtonWidget(
                                        comment: widget.comment,
                                      )
                                    : IconButton(
                                        onPressed: _onSave,
                                        icon: Icon(
                                          Icons.save,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 75,
                      child: !isEditing
                          ? Text(
                              widget.comment.content,
                            )
                          : InputField(
                              hintText: "Ecrivez ici...",
                              controller: contentController,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onProfileTap(BuildContext context, int userId) {
    UserPage.navigateTo(context, userId);
  }

  void _onSave() {
    final commentBloc = BlocProvider.of<CommentBloc>(context);

    commentBloc.add(
      PatchComment(
        content: contentController.text,
        comment: widget.comment,
      ),
    );
    isEditing = false;
  }
}
