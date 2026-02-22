import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:fhdw_chatbot/theme/app_colors.dart';
import 'package:fhdw_chatbot/theme/text_styles.dart';

import 'saved_careers_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final user = appState.userProfile;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Profile', style: AppTextStyles.h3),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.textMain,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profile Header
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.surfaceLight,
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: AppTextStyles.h1.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(user.name, style: AppTextStyles.h2),
            const SizedBox(height: 4),
            Text(
              'Grade 11 Student',
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Edit Profile Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Edit Profile'),
              ),
            ),
            const SizedBox(height: 32),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '12',
                          style: AppTextStyles.h2.copyWith(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Quizzes Taken',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '5',
                          style: AppTextStyles.h2.copyWith(
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Careers Saved',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // My Interests
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Interests', style: AppTextStyles.h3),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildInterestTag('Math'),
                _buildInterestTag('Coding'),
                _buildInterestTag('Design'),
                _buildInterestTag('Robotics'),
                _buildInterestTag('Problem Solving'),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Saved Careers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Saved Careers', style: AppTextStyles.h3),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedCareersScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSavedCareerCard('Software Engineer', '94% Match', Icons.code),
            const SizedBox(height: 12),
            _buildSavedCareerCard(
              'Architect',
              'Creative Field',
              Icons.architecture,
            ),
            const SizedBox(height: 12),
            _buildSavedCareerCard('Data Analyst', 'Explore', Icons.analytics),
            const SizedBox(height: 32),

            // Log Out Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: Colors.red,
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodySm.copyWith(
          color: AppColors.textMain,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSavedCareerCard(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryBlueLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLg.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textLight),
        ],
      ),
    );
  }
}
