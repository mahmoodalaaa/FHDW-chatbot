import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:fhdw_chatbot/theme/app_colors.dart';
import 'package:fhdw_chatbot/theme/text_styles.dart';

import 'chatbot_screen.dart';
import 'quiz_screen.dart';
import 'profile_screen.dart';
import 'result_screen.dart';
import 'saved_careers_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    final List<Widget> _pages = [
      _buildHomeDashboard(appState),
      const ChatbotScreen(),
      appState.isQuizLoading
          ? const QuizScreen() // QuizScreen handles its own loading state
          : appState.quizRecommendation != null
          ? ResultScreen(recommendation: appState.quizRecommendation!)
          : const QuizScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textLight,
        showUnselectedLabels: true,
        selectedLabelStyle: AppTextStyles.bodySm.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.bodySm,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeDashboard(AppState appState) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.surfaceLight,
                      child: Icon(Icons.person, color: AppColors.textSecondary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          appState.userProfile.name,
                          style: AppTextStyles.bodyMd.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textMain,
                  ),
                  onPressed: () {},
                ),
              ],
            ),

            Text(
              'Ready to explore your future today?',
              style: AppTextStyles.bodyLg.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 6),

            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlueLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.business_center,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('AI Career Assistant', style: AppTextStyles.h3),
                  const SizedBox(height: 8),
                  Text(
                    'Chat with our AI to discover paths tailored to your skills.',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.successGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Online now',
                            style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1; // Chat
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Start Chat'),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Personality Quiz Card
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 2; // Explore/Quiz
                });
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.tune, color: AppColors.primaryBlue),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personality Quiz',
                            style: AppTextStyles.bodyLg.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Find out what suits you best.',
                            style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.textLight),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Trending Careers Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trending Careers', style: AppTextStyles.h3),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedCareersScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: AppTextStyles.bodyMd.copyWith(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Trending Careers Horizontal List
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 8),
                children: [
                  _buildTrendingCareerCard(
                    title: 'Software Engineer',
                    salary: '\$80k - \$150k / year',
                    tag: 'HIGH DEMAND',
                    icon: Icons.code,
                  ),
                  const SizedBox(width: 16),
                  _buildTrendingCareerCard(
                    title: 'UX Designer',
                    salary: '\$70k - \$130k / year',
                    tag: 'CREATIVE',
                    icon: Icons.brush,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingCareerCard({
    required String title,
    required String salary,
    required String tag,
    required IconData icon,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.primaryBlue, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlueLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.primaryBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: AppTextStyles.bodyLg.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            salary,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
