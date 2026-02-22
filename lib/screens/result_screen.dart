import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:fhdw_chatbot/theme/app_colors.dart';
import 'package:fhdw_chatbot/theme/text_styles.dart';
import '../models/job_recommendation.dart';

class ResultScreen extends StatelessWidget {
  final JobRecommendation recommendation;

  const ResultScreen({Key? key, required this.recommendation})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final bool isSaved = appState.isCareerSaved(recommendation);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryBlue,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Career Match', style: AppTextStyles.h3),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_outline,
              color: AppColors.primaryBlue,
            ),
            onPressed: () {
              appState.toggleSavedCareer(recommendation);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${recommendation.matchPercentage}% Match',
                        style: AppTextStyles.bodySm.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Center(
                          child: Icon(
                            Icons.work,
                            size: 80,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 24,
                        left: 24,
                        right: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recommendation.jobTitle,
                              style: AppTextStyles.h1.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  recommendation.description,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.payments_outlined,
                              color: AppColors.primaryBlue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SALARY',
                                  style: AppTextStyles.bodySm.copyWith(
                                    color: AppColors.textLight,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  recommendation.salary,
                                  style: AppTextStyles.bodyMd.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                        child: Row(
                          children: [
                            const Icon(
                              Icons.trending_up,
                              color: AppColors.primaryBlue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'GROWTH',
                                  style: AppTextStyles.bodySm.copyWith(
                                    color: AppColors.textLight,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  recommendation.growth,
                                  style: AppTextStyles.bodyMd.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text('Typical Work Day', style: AppTextStyles.h3),
                  ],
                ),
                const SizedBox(height: 24),
                ...List.generate(recommendation.dailyTasks.length, (index) {
                  final task = recommendation.dailyTasks[index];
                  return _buildTimelineItem(
                    time: task.time,
                    title: task.title,
                    description: task.description,
                    icon: Icons.check_circle_outline,
                    isFirst: index == 0,
                    isLast: index == recommendation.dailyTasks.length - 1,
                  );
                }),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          appState.toggleSavedCareer(recommendation);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: isSaved
                              ? AppColors.primaryBlueLight
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: BorderSide(
                            color: isSaved
                                ? AppColors.primaryBlueLight
                                : AppColors.border,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border,
                              color: isSaved
                                  ? AppColors.primaryBlue
                                  : AppColors.textMain,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              isSaved ? 'Saved' : 'Save',
                              style: AppTextStyles.bodyMd.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isSaved
                                    ? AppColors.primaryBlue
                                    : AppColors.textMain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.chat_bubble_outline, size: 20),
                            const SizedBox(width: 8),
                            const Text('Ask Question'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String description,
    required IconData icon,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 2,
                height: 16,
                color: isFirst ? Colors.transparent : AppColors.border,
              ),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: isLast ? Colors.transparent : AppColors.border,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(icon, color: AppColors.primaryBlue, size: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: AppTextStyles.bodyLg.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
