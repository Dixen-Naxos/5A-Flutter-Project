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
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }

  _onDeleteButtonPressed() {
    Widget yesButton = ElevatedButton(
      child: Text("Oui"),
      onPressed: () {
        final detailPostBloc = BlocProvider.of<CommentBloc>(context);
        detailPostBloc.add(
          DeleteComment(
            comment: widget.comment,
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
      content: const Text("Voulez-vous vraiment supprimer ce commentaire ?"),
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
