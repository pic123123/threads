import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';

class User {
  final String userId;
  final String name;
  final String content;
  final String profileImg;
  final String followers;

  User({
    required this.userId,
    required this.name,
    required this.content,
    required this.profileImg,
    required this.followers,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      userId: doc['userId'],
      name: doc['name'],
      content: doc['content'],
      profileImg: doc['profileImg'],
      followers: doc['followers'],
    );
  }

//이 메소드는 Firestore에 데이터를 저장할 때 사용됩니다.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'content': content,
      'profileImg': profileImg,
      'followers': followers,
    };
  }
}

// /// dumyy data
// List<User> Users = [
//   User(
//     userId: 1,
//     name: "조커",
//     content: "개발자",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     followers: "26.6",
//     img: [],
//   ),
//   User(
//     userId: 2,
//     name: "이지금",
//     content: "IU",
//     profileImg:
//         "https://img.khan.co.kr/news/2023/05/12/news-p.v1.20230512.e5fffd99806f4dcabd8426d52788f51a_P1.webp",
//     followers: "301",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80"
//     ],
//   ),
//   User(
//     userId: 3,
//     name: "김민지",
//     content: "New Jeans",
//     profileImg:
//         "https://img.allurekorea.com/allure/2023/02/style_63fc43878c1d4.jpg",
//     followers: "278.9",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//     ],
//   ),
//   User(
//     userId: 4,
//     name: "이상혁",
//     content: "faker",
//     profileImg:
//         "https://news.koreadaily.com/data/photo/2023/08/10/202308101910774330_64d4b847390ce.jpg",
//     followers: "5",
//     img: [],
//   ),
//   User(
//     userId: 5,
//     name: "주현영",
//     content: "주기자",
//     profileImg:
//         "https://i.namu.wiki/i/Q-H__TaLXLw46znEdazfhjkADpqgnKQ2b8ydT_EdflBLFRbc2680Gp_R1BflBBJoJEKty2CZbfohN3p1tAqZZQ.webp",
//     followers: "36.8",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80"
//     ],
//   ),
//   User(
//     userId: 6,
//     name: "다이나믹듀오",
//     content: "우리가누구?",
//     profileImg:
//         "https://www.shinailbo.co.kr/news/photo/201511/476343_250499_1238.jpg",
//     followers: "221",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//     ],
//   ),
//   User(
//     userId: 7,
//     name: "쵸비",
//     content: "쵸오비비비비비상",
//     profileImg:
//         "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjA4MjhfMTQ5%2FMDAxNjYxNjc3NTA1Mzg3.eyXfrEWGJJ9WNcqoOa_trZStk5D8r7KixAKYsSP8j7Eg.Dhv2apWaVGatAy-OuY4qfcgwzH_m3oa-8vot5r74vjcg.JPEG.asmonaco_1919%2F51227_99136_361.jpg&type=sc960_832",
//     followers: "26.6",
//     img: [],
//   ),
//   User(
//     userId: 8,
//     name: "vicenews",
//     content: "VICE News",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     followers: "301",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80"
//     ],
//   ),
//   User(
//     userId: 9,
//     name: "trevornoah",
//     content: "Trevor Noah",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     followers: "278.9",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//     ],
//   ),
//   User(
//     userId: 4,
//     name: "joker",
//     content: "jajajaja",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     followers: "5",
//     img: [],
//   ),
//   User(
//     userId: 5,
//     name: "joker2",
//     content: "hohoho",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     followers: "36.8",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80"
//     ],
//   ),
//   User(
//     userId: 6,
//     name: "joker3",
//     content: "hehehe",
//     profileImg: "https://avatars.githubusercontent.com/u/40009719?v=4",
//     followers: "221",
//     img: [
//       "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
//     ],
//   ),
// ];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final logoImage = 'assets/images/twitter_logo.png';

  late List<User> _users = []; // All users data
  late List<User> _filteredUsers = []; // Filtered users data

  void _onLoginTab(context) {
    print("asd");
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('users').get();
    final List<DocumentSnapshot> documents = result.docs;
    _users = documents.map((doc) => User.fromDocument(doc)).toList();

    // Initialize filtered users with all users data.
    setState(() {
      _filteredUsers = List.from(_users);
    });
  }

  final TextEditingController _textEditingController =
      TextEditingController(text: "");

  ///검색창에 입력되는 값
  void _onSearchChanged(String value) {
    setState(() {
      _filteredUsers =
          _users.where((user) => user.name.contains(value)).toList();
    });
    print(value);
  }

  ///검생창에서 keyboard로 search 눌러서 전송하는 값
  void _onSearchSubmitted(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 1,

      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size14,
          vertical: Sizes.size10,
        ),
        child: SafeArea(
          /// Center Widget : 모든것을 가운데로 정렬
          child: Center(
            child: Column(
              /// mainAxisAlignment : MainAxisAlignment.start 세로축 맨위부터 시작
              mainAxisAlignment: MainAxisAlignment.start,

              /// 가로측 맨 왼쪽부터 시작
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Search",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                CupertinoSearchTextField(
                  controller: _textEditingController,
                  onChanged: _onSearchChanged,
                  onSubmitted: _onSearchSubmitted,
                ),
                Gaps.v20,

                /// Flutter에서 Column 위젯은 자식들을 세로 방향으로 배치하며, 가능한 모든 공간을 차지하려고 합니다.
                /// 따라서 ListView가 Column의 자식으로 있을 때, ListView는 무한대의 공간이 주어진 것처럼 인식하고,
                /// 그에 따라 오버플로우가 발생할 수 있습니다.
                /// 이 문제를 해결하기 위해선, Expanded 위젯을 사용하여 남아있는 공간에 대한 제어권을 Flutter에게 주면 됩니다.

                Expanded(
                  ///ListView.builder에서 각 항목 사이에 Divider를 추가하려면 ListView.separated를 사용할 수 있습니다.
                  ///이는 각 항목 사이에 분리자를 삽입하는 기능을 제공합니다.
                  child: ListView.separated(
                    shrinkWrap: true, // new line
                    itemCount: _filteredUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(_filteredUsers[index].profileImg),
                        ),
                        title: Row(
                          children: [
                            Text(
                              _filteredUsers[index].name,
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
                        subtitle: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // left align text
                          children: <Widget>[
                            Text(_filteredUsers[index].content),
                            Gaps.v5,
                            Text(
                              '${_filteredUsers[index].followers}K followers',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size8,
                            horizontal: Sizes.size20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(
                              Sizes.size10,
                            ),
                          ),
                          child: const Text(
                            "Follow",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },

                    separatorBuilder: (context, index) =>
                        const Divider(color: Colors.black26, thickness: 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
