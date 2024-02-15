import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/all_post_bloc/all_post_bloc.dart';
import '../../blocs/user_post_bloc/user_post_bloc.dart';
import '../../models/post.dart';

class DeleteButtonWidget extends StatefulWidget {
  const DeleteButtonWidget(
      {super.key, required this.post, this.isInsideDetail = false});

  final Post post;
  final bool isInsideDetail;

  @override
  State<DeleteButtonWidget> createState() => _DeleteButtonWidgetState();
}

class _DeleteButtonWidgetState extends State<DeleteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _onDeleteButtonPressed();
      },
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }

  _onDeleteButtonPressed() {
    Widget yesButton = ElevatedButton(
      child: Text("Oui"),
      onPressed: () {
        final detailPostBloc = BlocProvider.of<DetailPostBloc>(context);
        detailPostBloc.add(
          Delete(
            post: widget.post,
            isInsideDetail: widget.isInsideDetail,
          ),
        );

        final allPostBloc = BlocProvider.of<AllPostBloc>(context);
        allPostBloc.add(
          AllDeletePost(
            post: widget.post,
          ),
        );

        final userPostBloc = BlocProvider.of<UserPostBloc>(context);
        userPostBloc.add(
          UserDeletePost(
            post: widget.post,
          ),
        );

        Navigator.of(context).pop();
      },
    );

    Widget noButton = ElevatedButton(
      child: const Text("Non"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Suppression"),
      content: const Text("Voulez-vous vriament supprimer ce post ?"),
      actions: [
        yesButton,
        noButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
