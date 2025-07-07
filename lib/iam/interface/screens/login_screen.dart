import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/iam/interface/widgets/checkbox_remember.dart';
import 'package:ecoguardian/iam/interface/widgets/email_field.dart';
import 'package:ecoguardian/iam/interface/widgets/login_banner.dart';
import 'package:ecoguardian/iam/interface/providers/auth_provider.dart';
import 'package:ecoguardian/public/interface/widgets/custom_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/password_field.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Uri _url = Uri.parse('https://ecoguardian-tf.vercel.app/login');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final double containerHeight = MediaQuery.of(context).size.height * 0.25;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final Image logo = Image.asset(
      'assets/images/ecoguardian_logo.png',
      fit: BoxFit.contain,
    );

    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColors.lightGrey,
            body: Column(
              children: [
                LoginBanner(
                  containerHeight: containerHeight,
                  deviceWidth: deviceWidth,
                  logoImage: logo,
                ),
                Expanded(
                  child: SizedBox(
                    width: deviceWidth * 0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'EcoGuardian',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        const SizedBox(height: 30),
                        EmailField(emailController: _emailController),
                        const SizedBox(height: 25),
                        PasswordField(passwordController: _passwordController),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await authProvider.signIn(
                                _emailController.text,
                                _passwordController.text,
                              );
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: "Welcome to EcoGuardian!",
                                    content: "",
                                    isSuccess: true,
                                    onConfirm: () {
                                      context.go('/home');
                                    },
                                    onCancel: () {
                                      context.go('/home');
                                    },
                                  );
                                },
                              );
                            } catch (e) {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    title: "An error has ocurred",
                                    content:
                                        "Check your credentials and try again",
                                    isSuccess: false,
                                    onConfirm: () {
                                      Navigator.pop(context);
                                    },
                                    onCancel: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                CustomColors.primary, // Color de fondo
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            minimumSize: const Size(double.infinity, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.8,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text("Do you don't registered yet?"),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () async {
                            await _launchUrl();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            CustomColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            minimumSize: const Size(double.infinity, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: CustomColors.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.8,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
