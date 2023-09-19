import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/common/widgets/form_button.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Post {
  final int userId;
  final String name;
  final String content;
  final String profileImg;
  final List<String> img;

  Post({
    required this.userId,
    required this.name,
    required this.content,
    required this.profileImg,
    required this.img,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      userId: doc['userId'],
      name: doc['name'],
      content: doc['content'],
      profileImg: doc['profileImg'],
      img: List<String>.from(doc['img']),
    );
  }

//이 메소드는 Firestore에 데이터를 저장할 때 사용됩니다.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'content': content,
      'profileImg': profileImg,
      'img': img
    };
  }
}

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _contentsController =
      TextEditingController(text: "");

  String _content = "";

  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  List<XFile>? _images; // Change from XFile? to List<XFile>

  ///최종 저장
  void _onSave() async {
    // Upload each image and get their download URLs
    List<String> imageUrls = [];

    for (var image in _images!) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('${DateTime.now().millisecondsSinceEpoch}');
      await storageReference.putFile(File(image.path)).whenComplete(() => null);
      String imageUrl = await storageReference.getDownloadURL();

      imageUrls.add(imageUrl);
    }

//    Post newPost = Post(
//      userId : ... ,
//      name : ... ,
//      content : _contentsController.text ,
//      profileImg : ... ,
//      img : imageUrls ,
//  );
  }

  ///파이어베이스에 게시글 및 이미지 저장
  Future<void> savePost(Post post) async {
    // Create a reference to the location you want to upload to in firebase
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');

    // Upload file to firebase
    // await storageReference.putFile(post.img).whenComplete(() => null);

    // Get the download URL of uploaded image
    String imageUrl = await storageReference.getDownloadURL();

    // Save post data with imageUrl to firestore
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    await posts.add(post.toJson());
  }

  Future getImage() async {
    final List<XFile> pickedFiles =
        await picker.pickMultiImage(); // Use pickMultiImage()
    setState(() {
      _images = pickedFiles;
    });
  }

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
                  prefixIcon: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.paperclip,
                      size: Sizes.size20,
                    ),
                    onPressed: () => getImage(),
                  ),
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
              if (_images != null)
                for (var image in _images!)
                  Image.file(
                    File(image.path),
                    width: 200,
                    height: 150,
                  ),
              Gaps.v10,
              GestureDetector(
                onTap: () => _onSave(),
                child: const FormButton(
                  disabled: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
