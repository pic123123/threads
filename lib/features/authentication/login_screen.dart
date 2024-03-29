import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/common/widgets/auth_button.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/features/authentication/signup_screen.dart';
import 'package:threads/features/main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final logoImage = 'assets/images/threads_black_logo.png';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  final TextEditingController _emailController =
      TextEditingController(text: "test123@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "1a2a3a!!!");

  late String _email = "";
  late String _password = "";
  bool _obscureText = true;

  /// 비밀번호 입력값 초기화
  void _onClearTap() {
    _passwordController.clear();
  }

  /// 비밀번호 hide
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  /// 비밀번호 유효성 검사
  bool _isPasswordValid() {
    return _passwordController.text.isNotEmpty &&
        _passwordController.text.length > 8 &&
        _passwordController.text.length < 21;
  }

  void _onLogin(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        try {
          UserCredential userCredential =
              await _auth.signInWithEmailAndPassword(
            email: formData['email']!,
            password: formData['password']!,
          );
          // 로그인한 사용자의 정보가 존재하면 HomeScreen으로 이동합니다.
          if (userCredential.user != null) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainNavigationScreen(),
              ),

              ///이건 이전 기록이 있는 route를 모두 유지할지 말지 여부
              (route) => false,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainNavigationScreen(),
              ),
            );
          }
        } on FirebaseAuthException catch (e) {
          print(e.toString());
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        } catch (e) {
          // 추가된 부분
          // signInWithEmailAndPassword 메소드에서 던져진 모든 종류의 예외를 캐치합니다.
          // e.toString()을 통해 오류 메시지 전체를 출력할 수 있습니다.
          print('An error occurred while trying to log in: ${e.toString()}');
        }
      }
    }
  }

  void _onMoveSignupScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  ///마지막 실행, 모든게 다끝날때
  @override
  Future<void> dispose() async {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("English (US)"),
            Gaps.v40,
            Image.asset(
              logoImage,
              width: 100, // 원하는 너비로 설정
              height: 100, // 원하는 높이로 설정
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size40,
                  vertical: Sizes.size20,
                ),
                child: Center(
                  // Center widget was incorrectly placed in your original code.
                  child: Column(
                    // Column widget was incorrectly placed in your original code.
                    children: [
                      Gaps.v40,
                      // const Text(
                      //   "Create your account",
                      //   style: TextStyle(
                      //       fontSize: Sizes.size24,
                      //       fontWeight: FontWeight.w800),
                      // ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Gaps.v28,
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                suffixIcon: _email.isNotEmpty
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : null,
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Please enter your email.";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['email'] = newValue;
                                }
                              },
                            ),
                            Gaps.v16,
                            TextFormField(
                              controller: _passwordController,

                              /// 비밀번호처럼 ***으로 보이게함
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                suffix: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: _onClearTap,
                                      child: FaIcon(
                                        FontAwesomeIcons.solidCircleXmark,
                                        color: Colors.grey.shade500,
                                        size: Sizes.size20,
                                      ),
                                    ),
                                    Gaps.h16,
                                    GestureDetector(
                                      onTap: _toggleObscureText,
                                      child: FaIcon(
                                        _obscureText
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                        color: Colors.grey.shade500,
                                        size: Sizes.size20,
                                      ),
                                    )
                                  ],
                                ),
                                hintText: 'Password',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Please enter your password.";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  formData['password'] = newValue;
                                }
                              },
                            ),
                            Gaps.v16,
                            GestureDetector(
                              onTap: () => _onLogin(context),
                              child: const AuthButton(
                                text: "Log in",
                                disabled: false,
                              ),
                            ),
                            Gaps.v16,
                            const Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        color: Theme.of(context).bottomAppBarTheme.color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _onMoveSignupScreen(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                    horizontal: Sizes.size96,
                  ),
                  decoration: BoxDecoration(
                    // BoxDecoration을 이용해 테두리를 만듭니다.
                    border: Border.all(
                      color: Colors.grey,
                    ), // 원하는 색상과 두께로 설정 가능합니다.
                  ),
                  child: const Text(
                    'Create new account',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Gaps.v10,
              const Text("Meta"),
            ],
          ),
        ),
      ),
    );
  }
}
