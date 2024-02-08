import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/comment_bloc/comment_bloc.dart';
import '../../models/comment.dart';

class DeleteButtonWidget extends StatefulWidget {
  const DeleteButtonWidget({super.key, required this.comment});

  final Comment comment;

  @override
  State<DeleteButtonWidget> createState() => _DeleteButtonWidgetState();
}

class _DeleteButtonWidgetState extends State<DeleteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onDeleteButtonPressed,
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  _onDeleteButtonPressed() {
    final detailPostBloc = BlocProvider.of<CommentBloc>(context);
    detailPostBloc.add(
      DeleteComment(
        comment: widget.comment,
      ),
    );
  }
}
