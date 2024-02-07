import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/post_bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post.dart';

class DeleteButtonWidget extends StatefulWidget {
  const DeleteButtonWidget({super.key, required this.post});

  final Post post;

  @override
  State<DeleteButtonWidget> createState() => _DeleteButtonWidgetState();
}

class _DeleteButtonWidgetState extends State<DeleteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onDeleteButtonPressed,
      icon: const Icon(
        Icons.delete,
        color: Colors.redAccent,
      ),
    );
  }

  _onDeleteButtonPressed() {
    final detailPostBloc = BlocProvider.of<DetailPostBloc>(context);
    detailPostBloc.add(
      Delete(post: widget.post),
    );

    final postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(
      DeletePost(post: widget.post),
    );
  }
}
