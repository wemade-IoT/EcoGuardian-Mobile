import 'package:ecoguardian/config/theme/app_theme.dart';
<<<<<<< HEAD
import 'package:ecoguardian/iam/interface/widgets/checkbox_remember.dart';
import 'package:ecoguardian/iam/interface/widgets/email_field.dart';
import 'package:ecoguardian/iam/interface/widgets/login_banner.dart';
=======
import 'package:ecoguardian/iam/interface/providers/auth_provider.dart';

>>>>>>> 0ad34e2 (feat(iam): implemented sign-in)
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/checkbox_remember.dart';
import '../widgets/email_field.dart';
import '../widgets/login_banner.dart';
import '../widgets/password_field.dart';

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
                const SizedBox(height: 90),
                Expanded(
                  child: SizedBox(
                    width: deviceWidth * 0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'EcoGuardian',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        EmailField(emailController: _emailController),
                        const SizedBox(height: 25),
                        PasswordField(passwordController: _passwordController),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RememberCheckbox(),
                            Text(
                              "Forgot password?",
                              style: TextStyle(
                                fontSize: 14.5,
                                fontStyle: FontStyle.normal,
                                color: CustomColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async{
                            try{
                             final response = await authProvider.signIn(_emailController.text,_passwordController.text);
                            } finally{
                              context.go('/home');
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
                        const SizedBox(height: 20),
                        Expanded(child: Container(color: Colors.transparent)),
                        const _NotAccountText(),
                        const SizedBox(height: 15),
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

class _NotAccountText extends StatelessWidget {
  const _NotAccountText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.8,
          color: Colors.black,
        ),
        children: [
          const TextSpan(
            text: "Don't have an account? ",
          ),
          TextSpan(
            text: 'Sign up',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.teal,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push('/register');
              },
          ),
        ],
      ),
    );
  }
}
