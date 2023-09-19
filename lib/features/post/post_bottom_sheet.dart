import 'package:flutter/material.dart';
import 'package:threads/constants/sizes.dart';

class PostBottomSheet extends StatefulWidget {
  const PostBottomSheet({Key? key}) : super(key: key);

  @override
  State<PostBottomSheet> createState() => _PostBottomSheetState();
}

class _PostBottomSheetState extends State<PostBottomSheet> {
  ///Report  누르면 실행되는 함수
  void _onReportBottomSheet(BuildContext context) async {
    ///밑에서부터 올라오는 모달창 (모달밖은 저절로 회색으로 흐려짐)
    await showModalBottomSheet(
      context: context,

      /// bottom sheet의 사이즈를 바꿀 수 있게 해줌, (listView를 사용할거면 true)
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ReportBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.40,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        // appBar: AppBar(
        //   backgroundColor: Colors.grey.shade50,
        //   automaticallyImplyLeading: false,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size20),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.person_off),
                title: const Text('Unfollow'),
                onTap: () => {/* Do something */},
              ),
              const Divider(color: Colors.black26, thickness: 1),
              ListTile(
                leading: const Icon(Icons.volume_off),
                title: const Text('Mute'),
                onTap: () => {/* Do something */},
              ),
              const Divider(color: Colors.black26, thickness: 1),
              ListTile(
                leading: const Icon(Icons.visibility_off),
                title: const Text('Hide'),
                onTap: () => {/* Do something */},
              ),
              const Divider(color: Colors.black26, thickness: 1),
              ListTile(
                leading: const Icon(Icons.report),
                title: const Text(
                  'Report',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => _onReportBottomSheet(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReportBottomSheet extends StatelessWidget {
  const ReportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text(
            "Report",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size20),
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Why are you reporting this thread?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Your report is annonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergeny services - don't wait",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.black26, thickness: 1),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('I just don\'t like it'),
                  onTap: () => {/* Do something */},
                ),
                const Divider(color: Colors.black26, thickness: 1),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('It\'s unlawful content under NetzDG'),
                  onTap: () => {/* Do something */},
                ),
                const Divider(color: Colors.black26, thickness: 1),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('its spam'),
                  onTap: () => {/* Do something */},
                ),
                const Divider(color: Colors.black26, thickness: 1),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('Hate speech or symbols'),
                  onTap: () => {/* Do something */},
                ),
                const Divider(color: Colors.black26, thickness: 1),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('Nudity or sexual activity'),
                  onTap: () => {/* Do something */},
                ),
                const Divider(color: Colors.black26, thickness: 1),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('its spam'),
                  onTap: () => {/* Do something */},
                ),
                const Divider(color: Colors.black26, thickness: 1),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('its spam'),
                  onTap: () => {/* Do something */},
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // body: ListView(children: const [
    //   ListTile(title: Text("I just don't like it")),
    //   ListTile(title: Text("It's unlawful content under NetzDG"))
    // ]),
  }
}
