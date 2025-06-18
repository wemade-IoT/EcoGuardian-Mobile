import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'profile_screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(color: CustomColors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: CustomColors.white),
            onPressed: () {},
          ),
        ],
        backgroundColor: CustomColors.darkGreen,
        elevation: 0,
      ),
      backgroundColor: CustomColors.lightGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: 24),
                  _buildUserDetailsSection(),
                  const SizedBox(height: 24),
                  _buildSubscriptionSection(),
                ],
              ),
            ),
      ),
    );
  }
}