import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';

import '../models/job_recommendation.dart';
import 'result_screen.dart';

class SavedCareersScreen extends StatelessWidget {
  const SavedCareersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final savedCareers = appState.savedCareers;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Saved Careers', style: AppTextStyles.h4),
        centerTitle: true,
      ),
      body: SafeArea(
        child: savedCareers.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bookmark_border,
                      size: 64,
                      color: AppColors.textLight,
                    ),
                    const SizedBox(height: 16),
                    Text('No saved careers yet', style: AppTextStyles.h3),
                    const SizedBox(height: 8),
                    Text(
                      'Explore and save careers that interest you.',
                      style: AppTextStyles.bodyMd.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: savedCareers.length,
                itemBuilder: (context, index) {
                  return _buildCareerCard(context, savedCareers[index]);
                },
              ),
      ),
    );
  }

  Widget _buildCareerCard(BuildContext context, JobRecommendation career) {
    return GestureDetector(
      onTap: () {
        // Navigate to the result screen to view details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(recommendation: career),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
        child: Row(
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    career.jobTitle,
                    style: AppTextStyles.bodyLg.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${career.matchPercentage}% Match',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• ${career.growth} Growth',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}
