import 'dart:io';

import 'package:flutter/material.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _contentsController =
      TextEditingController(text: "");

  String _content = "";

  void _onSave() {
    print("123");
  }

  File? _image; //이미지를 담을 변수 선언

  // void _onMoveCameraScreen(BuildContext context) async {
  //   final XFile? selectedImage = await showModalBottomSheet(
  //     context: context,

  //     /// bottom sheet의 사이즈를 바꿀 수 있게 해줌, (listView를 사용할거면 true)
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => const CameraBottomSheet(),
  //   );
  //   if (selectedImage != null) {
  //     // Use your image here.
  //     print("Selected Image Path : ${selectedImage.path}");
  //     setState(() {
  //       _image = File(selectedImage.path);
  //     });
  //   }
  // }

  @override
  Future<void> dispose() async {
    _contentsController.dispose();
    super.dispose();
  }

  bool isInputComplete() {
    // Check if all text controllers have non-empty text
    return _contentsController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _contentsController.addListener(() {
      setState(() {
        _content = _contentsController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.95,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: Sizes.size12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          title: const Text(
            'New thread',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size16,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            Sizes.size20,
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/40009719?v=4"),
                  ),
                  Gaps.h10,
                  Text(
                    "Joker",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _contentsController,
                maxLength: 300,
                maxLines: 15,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: '내용을 입력해 주세요.',
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                    horizontal: Sizes.size10,
                  ),
                  // prefixIcon: const IconButton(
                  //   icon: FaIcon(
                  //     FontAwesomeIcons.paperclip,
                  //     size: Sizes.size20,
                  //   ),
                  //   // onPressed: () => _onMoveCameraScreen(context),
                  // ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              _image == null
                  ? const Text('')
                  : Image.file(
                      _image!,
                      width: 200, // 이미지의 원하는 너비를 설정하세요.
                      height: 150, // 이미지의 원하는 높이를 설정하세요.
                      fit: BoxFit.cover,
                    ),
              Gaps.v10,
              // GestureDetector(
              //   onTap: () => _onSave(),
              //   child: FormButton(
              //     disabled: false,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
