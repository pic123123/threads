import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/features/home/home_screen.dart';
import 'package:threads/features/nav.tab.dart';
import 'package:threads/features/post/post_screen.dart';
import 'package:threads/features/search/search_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  ///시작 페이지
  late int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///post_video_button widgets -> gogo
  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Record video')),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  void _onMovePostScreen(BuildContext context) async {
    ///밑에서부터 올라오는 모달창 (모달밖은 저절로 회색으로 흐려짐)
    await showModalBottomSheet(
      context: context,

      /// bottom sheet의 사이즈를 바꿀 수 있게 해줌, (listView를 사용할거면 true)
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PostScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final router = GoRouter.of(context);
    // _selectedIndex = _tabs.indexOf(router.location);

    return Scaffold(
      /// 키보드가 나타날때 기본적으로 Scaffold가 body를 조절해서 키보드가 화면을 가리지 않도로 한다.
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex != 0 ? Colors.black : Colors.white,

      ///같은 로직의 네비게이션을 사용하게 될 경우, 사용자가 다른 화면으로 갈 때마다
      ///index를 바꾸게 되고 이전화면은 완전히 없어진다.
      ///Home -> Profile -> Home 돌아오면 이전에 보던 영상이 없어짐
      ///Offstage : widget이 안보이게 하면서 계속 존재하게 해주는 widget
      ///Stack : 여러 widget들으 하나씩 쌓을때 사용하는 widget
      body: Stack(
        children: [
          Offstage(
            ///child의 화면을 보여줄지 말지 정할 수 있음(기본적으로 감추고있음 false)
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const SearchScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const PostScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            // child: const ActivityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            // child: const ProfileScreen(),
          )
        ],
      ),

      ///custom navigation
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(
              Sizes.size12,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///Column은 기본적으로 세로축으로 최대한 확장하려고 한다.

                  NavTab(
                    //  text: "Home",
                    isSelected: _selectedIndex == 0,
                    icon: FontAwesomeIcons.house,
                    selectedIcon: FontAwesomeIcons.house,
                    onTap: () => _onTap(0),
                    selectedIndex: _selectedIndex,
                  ),

                  NavTab(
                    //   text: "Search",
                    isSelected: _selectedIndex == 1,
                    icon: FontAwesomeIcons.magnifyingGlass,
                    selectedIcon: FontAwesomeIcons.magnifyingGlass,
                    onTap: () => _onTap(1),
                    selectedIndex: _selectedIndex,
                  ),
                  // Gaps.h24,
                  NavTab(
                    // text: "Post",
                    isSelected: _selectedIndex == 2,
                    icon: FontAwesomeIcons.penToSquare,
                    selectedIcon: FontAwesomeIcons.solidPenToSquare,
                    onTap: () => _onMovePostScreen(context),
                    selectedIndex: _selectedIndex,
                  ),
                  // GestureDetector(
                  //   onTap: _onPostVideoButtonTap,
                  //   child: PostVideoButton(inverted: _selectedIndex != 0),
                  // ),
                  // Gaps.h24,
                  NavTab(
                    //  text: "Actibity",
                    isSelected: _selectedIndex == 3,
                    icon: FontAwesomeIcons.heart,
                    selectedIcon: FontAwesomeIcons.solidHeart,
                    onTap: () => _onTap(3),
                    selectedIndex: _selectedIndex,
                  ),
                  NavTab(
                    // text: "Profile",
                    isSelected: _selectedIndex == 4,
                    icon: FontAwesomeIcons.user,
                    selectedIcon: FontAwesomeIcons.solidUser,
                    onTap: () => _onTap(4),
                    selectedIndex: _selectedIndex,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
