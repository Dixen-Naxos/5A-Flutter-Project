import 'package:cinqa_flutter_project/widgets/pages/create_post_page.dart';
import 'package:flutter/material.dart';

class NewPostButtonWidget extends StatelessWidget {
  const NewPostButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {_onFloatingButtonPressed(context)},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.add),
    );
  }

  void _onFloatingButtonPressed(BuildContext context) {
    CreatePostPage.navigateTo(context);
  }
}
