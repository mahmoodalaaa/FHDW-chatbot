import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:fhdw_chatbot/theme/app_colors.dart';
import 'package:fhdw_chatbot/theme/text_styles.dart';
import '../models/job_recommendation.dart';
import '../screens/result_screen.dart';
import '../models/dummy_data.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      Provider.of<AppState>(
        context,
        listen: false,
      ).sendMessage(_controller.text.trim());
      _controller.clear();

      // Scroll to bottom after sending
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final messages = appState.chatHistory;

    return Scaffold(
      backgroundColor: AppColors.surfaceLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: Column(
          children: [
            Text('Career AI', style: AppTextStyles.h3),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.successGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Online',
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textMain),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: messages.length + 1, // +1 for the date header
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }

                final msg = messages[index - 1];
                final isUser = msg.isUser;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isUser) ...[
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(
                            0xFF1E293B,
                          ), // Dark slate suitable for AI bot icon
                          child: Icon(
                            Icons.smart_toy,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: _buildMessageBubble(context, msg, isUser),
                      ),
                      if (isUser) ...[
                        // Optional: Avatar for user if desired, matching AI spacing
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          // Input Area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: AppColors.textLight,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Type what you like...',
                                hintStyle: AppTextStyles.bodyMd.copyWith(
                                  color: AppColors.textLight,
                                ),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryBlue,
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                onPressed: _sendMessage,
                                padding: EdgeInsets.zero,
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
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    ChatMessage msg,
    bool isUser,
  ) {
    if (isUser) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Text(
          msg.text,
          style: AppTextStyles.bodyLg.copyWith(
            color: Colors.white,
            height: 1.4,
          ),
        ),
      );
    }

    try {
      final parsed = jsonDecode(msg.text);
      if (parsed is Map<String, dynamic> && parsed.containsKey('jobTitle')) {
        final recommendation = JobRecommendation.fromJson(parsed);
        return _buildJobCard(context, recommendation);
      }
    } catch (_) {}

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        msg.text,
        style: AppTextStyles.bodyLg.copyWith(
          color: AppColors.textMain,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, JobRecommendation rec) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(recommendation: rec),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.work, color: AppColors.primaryBlue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    rec.jobTitle,
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              rec.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${rec.matchPercentage}% Match',
                  style: AppTextStyles.bodySm.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.successGreen,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.textLight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
