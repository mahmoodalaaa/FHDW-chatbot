import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/dummy_data.dart';
import '../models/job_recommendation.dart';
import '../services/openai_service.dart';

class AppState extends ChangeNotifier {
  UserProfile userProfile = UserProfile(
    name: "Alex Doe",
    email: "alex@example.com",
    bio:
        "Computer Science student passionate about AI and software engineering.",
  );

  List<ChatMessage> chatHistory = [
    ChatMessage(
      text: "Hello! I'm your AI Career Guide. How can I help you today?",
      isUser: false,
    ),
  ];

  List<CareerMatch> careerMatches = [
    CareerMatch(
      title: "Software Engineer",
      percentage: 95,
      description: "Builds and maintains software applications.",
    ),
    CareerMatch(
      title: "Data Scientist",
      percentage: 88,
      description:
          "Analyzes and interprets complex data to help companies make decisions.",
    ),
    CareerMatch(
      title: "Product Manager",
      percentage: 82,
      description:
          "Guides the success of a product and leads the cross-functional team that is responsible for improving it.",
    ),
  ];

  List<JobRecommendation> savedCareers = [];
  JobRecommendation? quizRecommendation;
  bool isQuizLoading = false;

  bool isQuizCompleted = false;

  void toggleSavedCareer(JobRecommendation recommendation) {
    if (isCareerSaved(recommendation)) {
      savedCareers.removeWhere((c) => c.jobTitle == recommendation.jobTitle);
    } else {
      savedCareers.add(recommendation);
    }
    notifyListeners();
  }

  bool isCareerSaved(JobRecommendation recommendation) {
    return savedCareers.any((c) => c.jobTitle == recommendation.jobTitle);
  }

  Future<void> sendMessage(String text) async {
    chatHistory.add(ChatMessage(text: text, isUser: true));
    notifyListeners();

    // Convert current chat history to OpenAI format
    final history = chatHistory
        .map(
          (msg) => {
            "role": msg.isUser ? "user" : "assistant",
            "content": msg.text,
          },
        )
        .toList();

    // Call OpenAI service
    final response = await OpenAIService.getChatResponse(text, history);

    chatHistory.add(ChatMessage(text: response, isUser: false));
    notifyListeners();
  }

  void completeQuiz() {
    isQuizCompleted = true;
    notifyListeners();
  }

  Future<void> submitQuiz(List<String> answers) async {
    isQuizLoading = true;
    notifyListeners();

    final prompt =
        """
A user has completed a career assessment quiz. Here are their answers:
${answers.asMap().entries.map((e) => "${e.key + 1}. ${e.value}").join("\n")}

Based on these answers, provide a professional career recommendation.
""";

    try {
      final response = await OpenAIService.getChatResponse(prompt, []);
      final parsed = jsonDecode(response);
      if (parsed is Map<String, dynamic> && parsed.containsKey('jobTitle')) {
        quizRecommendation = JobRecommendation.fromJson(parsed);
        isQuizCompleted = true;
      }
    } catch (e) {
      print("Error submitting quiz: $e");
    } finally {
      isQuizLoading = false;
      notifyListeners();
    }
  }
}
