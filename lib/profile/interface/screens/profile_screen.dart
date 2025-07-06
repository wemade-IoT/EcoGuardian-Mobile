import 'package:ecoguardian/config/theme/app_theme.dart';
import 'package:ecoguardian/profile/interface/providers/profile_provider.dart';
import 'package:ecoguardian/public/interface/widgets/custom_elevated_button.dart';
import 'package:ecoguardian/shared/infrastructure/helpers/storage_helper.dart';
import 'package:ecoguardian/shared/interface/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'profile_screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProfileHeader(context),
                  const SizedBox(height: 24),
                  _buildUserDetailsSection(context),
                  const SizedBox(height: 24),
                  _buildSubscriptionSection(),
                  const SizedBox(height: 24),
                  CustomElevatedButton(
                      onPressed: () async{
                        await StorageHelper.removeCredentials();
                        context.go("/");
                      },
                      background: Colors.red,
                      foreground: CustomColors.white,
                      label:"Sign Out"
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  profileProvider.profile != null ?   profileProvider.profile.avatarUrl
                      : "https://www.pngitem.com/pimgs/m/421-4212617_person-placeholder-image-transparent-hd-png-download.png",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: CustomColors.teal,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CustomColors.white,
                    width: 2,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt,
                    color: CustomColors.white,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            profileProvider.profile != null ?
            profileProvider.profile.name : 'Alex Johnson',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColors.darkGreen,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profileProvider.profile != null ?
            profileProvider.profile.email :
            'alex.johnson@example.com',
            style: TextStyle(
              fontSize: 16,
              color: CustomColors.grey,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildUserDetailsSection(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final Map<int,String> types = {
      1: "Admin",
      2:"Domestic",
      3: "Business",
      4: "Specialist",
    };
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'User Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.darkGreen,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildDetailRow(
                  label: 'User:',
                  value:
                  profileProvider.profile != null ?
                  profileProvider.profile.name :
                  'Alex Johnson',
                  icon: Icons.person,
                ),
                const Divider(height: 24),
                _buildDetailRow(
                  label: 'Profile:',
                  value: profileProvider.profile != null ?
                  types[profileProvider.profile.subscriptionId]! : "Not given",
                  icon: Icons.badge,
                ),
                const Divider(height: 24),
                _buildDetailRow(
                  label: 'Name:',
                  value:
                  profileProvider.profile != null ?
                  profileProvider.profile.name:
                  'Alex Johnson',
                  icon: Icons.person_outline,
                  isEditable: true,
                ),
                const Divider(height: 24),
                _buildDetailRow(
                  label: 'Email:',
                  value:  profileProvider.profile != null ?
                  profileProvider.profile.email:
                  'alex.johnson@example.com',
                  icon: Icons.email_outlined,
                ),
                const Divider(height: 24),
                _buildDetailRow(
                  label: 'Account Type:',
                  value: 'Generic Subcription',
                  icon: Icons.verified_user_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Current Subscription',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomColors.darkGreen,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: CustomColors.primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.card_membership,
                        color: CustomColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Subscription Plan',
                            style: TextStyle(
                              fontSize: 16,
                              color: CustomColors.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Annual Plan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.darkGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    required String value,
    required IconData icon,
    bool isEditable = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: CustomColors.teal,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: CustomColors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.darkGreen,
                ),
              ),
            ],
          ),
        ),
        if (isEditable)
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: CustomColors.teal,
              size: 20,
            ),
            onPressed: () {},
          ),
      ],
    );
  }
}

