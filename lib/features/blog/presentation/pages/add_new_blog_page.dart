import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/core/theme/app_pallete.dart';
import 'package:music_app/core/utils/pick_image.dart';
import 'package:music_app/features/blog/presentation/pages/widgets/blog_editor.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (builder) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List<String> selectedTopic = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titlecontroller.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.done))],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: SizedBox(
                        height: 200,
                        child: ClipRRect(
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: DottedBorder(
                          color: AppPallete.borderColor,
                          radius: const Radius.circular(10),
                          borderType: BorderType.RRect,
                          strokeCap: StrokeCap.round,
                          dashPattern: const [20, 4],
                          child: const SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Your Image',
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          )),
                    ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Pprogramming',
                    'Entertainment'
                  ]
                      .map((e) => Padding(
                            padding: const EdgeInsets.only(top: 5, right: 5),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedTopic.contains(e)) {
                                  selectedTopic.remove(e);
                                } else {
                                  selectedTopic.add(e);
                                }
                                setState(() {});
                              },
                              child: Chip(
                                label: Text(e),
                                color: selectedTopic.contains(e)
                                    ? const MaterialStatePropertyAll(
                                        AppPallete.gradient1)
                                    : const MaterialStatePropertyAll(
                                        AppPallete.backgroundColor,
                                      ),
                                side: selectedTopic.contains(e)
                                    ? null
                                    : const BorderSide(
                                        color: AppPallete.borderColor),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(controller: titlecontroller, hintText: "Blog Title"),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(
                  controller: contentController, hintText: "Blog Content")
            ],
          ),
        ),
      ),
    );
  }
}
