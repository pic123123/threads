import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';

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
}

/// dumyy data
List<Post> Posts = [
  Post(
    userId: 1,
    name: "joker",
    content: "I like you",
    profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
    img: [],
  ),
  Post(
    userId: 2,
    name: "bbong",
    content: "I like you, too",
    profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
    // profileImg: "",
    img: [
      "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
      "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80"
    ],
  ),
  Post(
    userId: 3,
    name: "seul",
    content: "I like you, all",
    profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
    // profileImg: "",
    img: [
      "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
    ],
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//ListView는 각 항목의 높이가 다를 때 유용하며, GridView는 모든 항목이 동일한 크기를 가질 때 잘 작동합니다.
class _HomeScreenState extends State<HomeScreen> {
  ///comments 아이콘 누르면 실행되는 함수
  void _onCommentsTap(BuildContext context) async {
    // ///밑에서부터 올라오는 모달창 (모달밖은 저절로 회색으로 흐려짐)
    // await showModalBottomSheet(
    //   context: context,

    //   /// bottom sheet의 사이즈를 바꿀 수 있게 해줌, (listView를 사용할거면 true)
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   builder: (context) => const PostBottomSheet(),
    // );
  }

  final logoImage = 'assets/images/twitter_logo.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: Posts.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(
                  Sizes.size10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(Posts[index].profileImg),
                        ),
                        Gaps.h10,
                        Column(
                          //Column은 기본적인 정렬방식이 세로축 중앙이다.
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  Posts[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gaps.h10,
                                FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: Sizes.size20,
                                  color: Colors.blue[400],
                                ),
                              ],
                            ),
                            Gaps.v10,
                            Text(
                              Posts[index].content,
                            ),
                          ],
                        ),

                        const Spacer(), // This will take up all remaining space in the row
                        Gaps.h10,
                        const Text(
                          "2h",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Gaps.h10,
                        GestureDetector(
                          onTap: () => _onCommentsTap(context),
                          child: const FaIcon(
                            FontAwesomeIcons.ellipsis,
                          ),
                        ),

                        Gaps.h10,
                      ],
                    ),
                    Gaps.v10,
                    if (Posts[index].img.isNotEmpty)
                      AspectRatio(
                        aspectRatio: 2 / 1,
                        child: Posts[index].img.length > 1
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Posts[index].img.length,
                                itemBuilder: (context, i) => Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: AspectRatio(
                                    aspectRatio: 2 / 1,
                                    child: Image.network(Posts[index].img[i],
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              )
                            : Image.network(Posts[index].img[0],
                                fit: BoxFit.fill),
                      ),
                    Gaps.v10,
                    Row(
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.heart,
                        ),
                        Gaps.h10,
                        FaIcon(
                          FontAwesomeIcons.comment,
                        ),
                        Gaps.h10,
                        FaIcon(
                          FontAwesomeIcons.recycle,
                        ),
                        Gaps.h10,
                        FaIcon(
                          FontAwesomeIcons.paperPlane,
                        )
                      ],
                    ),
                    Gaps.v10,
                    Row(
                      children: const [
                        Text(
                          "8 replies",
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                        Text("."),
                        Text(
                          "74 likes",
                          style: TextStyle(fontWeight: FontWeight.w200),
                        )
                      ],
                    ),
                    Gaps.v5,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
