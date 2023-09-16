import 'package:flutter/material.dart';
import 'package:threads/common/widgets/auth_button.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/constants/sizes.dart';
import 'package:threads/features/authentication/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final logoImage = 'assets/images/threads_black_logo.png';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");

  late String _email = "";
  late String _password = "";

  void _onSignup(context) async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        print("signup");
      }
    }
  }

  void _onMoveLoginScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
                              decoration: InputDecoration(
                                suffixIcon: _password.isNotEmpty
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green)
                                    : null,
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
                              onTap: () => _onSignup(context),
                              child: const AuthButton(
                                text: "Sign up",
                                disabled: false,
                              ),
                            ),
                            // Gaps.v16,
                            // const Text(
                            //   "Forgot password?",
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
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
                onTap: () => _onMoveLoginScreen(context),
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
                    'Log In',
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
