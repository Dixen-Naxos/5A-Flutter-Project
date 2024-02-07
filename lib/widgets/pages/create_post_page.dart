import 'dart:io';

import 'package:cinqa_flutter_project/blocs/all_post_bloc/all_post_bloc.dart';
import 'package:cinqa_flutter_project/blocs/detail_post_bloc/detail_post_bloc.dart';
import 'package:cinqa_flutter_project/widgets/button_widgets/button_widget.dart';
import 'package:cinqa_flutter_project/widgets/input_widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  static const String routeName = "/createPostPage";

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController postController = TextEditingController();

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DetailPostBloc, DetailPostState>(
        listener: (context, state) {
          if (state.status == DetailPostStatus.success) {
            final allPostBloc = BlocProvider.of<AllPostBloc>(context);

            allPostBloc.add(GetPosts(
              page: 1,
              perPage: 15,
            ));
            Navigator.pop(context);
          }
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => _onArrowBackClic(context),
                icon: const Icon(Icons.arrow_back),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InputField(
                  hintText: "Ecrivez ici : ",
                  controller: postController,
                  multiline: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 5),
                child: Row(
                  children: [
                    ButtonWidget(
                      onTap: _onOpenImage,
                      text: "Selectionnez une image",
                    ),
                    if (_image != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: ElevatedButton(
                          onPressed: _onResetImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 200, maxWidth: 200),
                          child: Image.file(_image!),
                        ),
                      ],
                    ),
                  ),
                ),
              ButtonWidget(
                onTap: _onPoster,
                text: "Poster",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onArrowBackClic(BuildContext context) {
    Navigator.pop(context);
  }

  void _onOpenImage() async {
    try {
      final imagePicker = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (imagePicker == null) return;
      setState(() {
        _image = File(imagePicker.path);
      });
    } catch (e) {
      print(e);
    }
  }

  void _onResetImage() {
    setState(() {
      _image = null;
    });
  }

  void _onPoster() {
    final detailPostBloc = BlocProvider.of<DetailPostBloc>(context);

    detailPostBloc.add(CreatePost(
      image: _image,
      content: postController.text,
    ));
  }
}
