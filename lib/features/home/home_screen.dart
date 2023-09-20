import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  /// DocumentSnapshot은 Firebase Firestore에서 사용하는 클래스입니다.
  /// Firestore 데이터베이스에서 하나의 문서(document)를 나타내며,
  /// 이 문서는 키-값 쌍으로 이루어진 데이터를 포함하고 있습니다.
  /// factory constructor to create a Post from a firestore document
  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      userId: doc['userId'],
      name: doc['name'],
      content: doc['content'],
      profileImg: doc['profileImg'],
      img: List<String>.from(doc['img']),
    );
  }
}

final postsProvider = StreamProvider<List<Post>>((ref) async* {
  FirebaseFirestore db = FirebaseFirestore.instance;

  yield* db.collection('posts').snapshots().map((snapshot) {
    var posts = snapshot.docs.map((doc) {
      print("Doc data: ${doc.data()}"); // print the document data
      return Post.fromDocument(doc);
    }).toList();
    print("Posts: $posts"); // print the list of posts
    return posts;
  });
});

// /// dumyy data
// List<Post> Posts = [
//   Post(
//     userId: 1,
//     name: "joker",
//     content: "I like you",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     img: [],
//   ),
//   Post(
//     userId: 2,
//     name: "bbong",
//     content: "I like you, too",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     // profileImg: "",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80"
//     ],
//   ),
//   Post(
//     userId: 3,
//     name: "seul",
//     content: "I like you, all",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     // profileImg: "",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//     ],
//   ),
// ];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  final logoImage = 'assets/images/twitter_logo.png';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Post>> postsAsyncValue = ref.watch(postsProvider);

    return Scaffold(
      body: SafeArea(
        child: postsAsyncValue.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (List<Post> posts) => ListView.builder(
            itemCount: posts.length,
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
                            backgroundImage: NetworkImage(
                              (posts[index].profileImg ??
                                  'https://avatars.githubusercontent.com/u/40009719?v=4'),
                            ),
                            // backgroundImage: NetworkImage(
                            //   posts[index].profileImg ??
                            //   "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                            // ),
                          ),
                          Gaps.h10,
                          Column(
                            //Column은 기본적인 정렬방식이 세로축 중앙이다.
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    posts[index].name,
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
                                posts[index].content,
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
                            // onTap: () => _onCommentsTap(context),
                            child: const FaIcon(
                              FontAwesomeIcons.ellipsis,
                            ),
                          ),

                          Gaps.h10,
                        ],
                      ),
                      Gaps.v10,
                      if (posts[index].img.isNotEmpty)
                        AspectRatio(
                          aspectRatio: 2 / 1,
                          child: posts[index].img.length > 1
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: posts[index].img.length,
                                  itemBuilder: (context, i) => Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: AspectRatio(
                                      aspectRatio: 2 / 1,
                                      child: Image.network(posts[index].img[i],
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                )
                              : Image.network(posts[index].img[0],
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
      ),
    );
  }
}
