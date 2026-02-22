import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:fhdw_chatbot/theme/app_colors.dart';
import 'package:fhdw_chatbot/theme/text_styles.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  final List<String> _answers = [];

  final List<Map<String, dynamic>> _quizData = [
    {
      "question": "How do you feel about working in a fast-paced environment?",
      "icon": Icons.speed,
      "options": [
        {"title": "Love it", "subtitle": "I thrive under pressure"},
        {"title": "It's okay", "subtitle": "I can handle it occasionally"},
        {"title": "Prefer calm", "subtitle": "I like steady, quiet work"},
      ],
    },
    {
      "question": "Do you prefer working with people or technology?",
      "icon": Icons.groups,
      "options": [
        {
          "title": "People",
          "subtitle": "I love interacting and guiding others",
        },
        {
          "title": "Technology",
          "subtitle": "I prefer focusing on systems and code",
        },
        {"title": "A bit of both", "subtitle": "I like a balanced mix"},
      ],
    },
    {
      "question": "Are you more analytical or creative?",
      "icon": Icons.lightbulb_outline,
      "options": [
        {"title": "Analytical", "subtitle": "I rely on data and logic"},
        {"title": "Creative", "subtitle": "I rely on intuition and design"},
      ],
    },
    {
      "question": "What kind of impact do you want your work to have?",
      "icon": Icons.public,
      "options": [
        {
          "title": "Social Impact",
          "subtitle": "Helping people and society directly",
        },
        {
          "title": "Technical Innovation",
          "subtitle": "Building cutting-edge tools",
        },
        {
          "title": "Business Success",
          "subtitle": "Driving growth and efficiency",
        },
      ],
    },
    {
      "question": "How do you prefer to solve problems?",
      "icon": Icons.psychology,
      "options": [
        {"title": "Structured", "subtitle": "Step-by-step logic and process"},
        {
          "title": "Intuitive",
          "subtitle": "Seeing the big picture and patterns",
        },
        {"title": "Collaborative", "subtitle": "Brainstorming with a team"},
      ],
    },
    {
      "question": "Build vs Optimize: which excites you more?",
      "icon": Icons.construction,
      "options": [
        {"title": "Building New", "subtitle": "Starting from a blank canvas"},
        {"title": "Optimizing", "subtitle": "Making existing things better"},
      ],
    },
    {
      "question": "What's more important to you currently?",
      "icon": Icons.balance,
      "options": [
        {
          "title": "Work-Life Balance",
          "subtitle": "Flexibility and personal time",
        },
        {
          "title": "Rapid Growth",
          "subtitle": "Intensity and quick advancement",
        },
      ],
    },
    {
      "question": "Do you enjoy presenting your ideas to a group?",
      "icon": Icons.record_voice_over,
      "options": [
        {"title": "Yes", "subtitle": "I love communicating my vision"},
        {"title": "No", "subtitle": "I prefer working behind the scenes"},
        {"title": "Sometimes", "subtitle": "Depends on the topic and group"},
      ],
    },
    {
      "question": "Which field interests you most?",
      "icon": Icons.category,
      "options": [
        {"title": "Math & Logic", "subtitle": "Calculations and algorithms"},
        {"title": "Arts & Design", "subtitle": "Visuals and user experience"},
        {"title": "Social Sciences", "subtitle": "Human behavior and society"},
        {"title": "Natural Sciences", "subtitle": "Environment and health"},
      ],
    },
    {
      "question": "What is your ideal work setting?",
      "icon": Icons.corporate_fare,
      "options": [
        {"title": "Office", "subtitle": "Structured corporate environment"},
        {"title": "Remote", "subtitle": "Work from anywhere with speed"},
        {"title": "Outdoors", "subtitle": "Field work and physical activity"},
        {"title": "Small Studio", "subtitle": "Close-knit creative team"},
      ],
    },
  ];

  void _nextQuestion() {
    if (_selectedOptionIndex == null) return;

    final currentOptions =
        _quizData[_currentQuestionIndex]["options"]
            as List<Map<String, String>>;
    final selectedOption = currentOptions[_selectedOptionIndex!];
    final answerText =
        "${_quizData[_currentQuestionIndex]["question"]}: ${selectedOption["title"]} (${selectedOption["subtitle"]})";
    _answers.add(answerText);

    if (_currentQuestionIndex < _quizData.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    } else {
      Provider.of<AppState>(context, listen: false).submitQuiz(_answers);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    if (appState.isQuizLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppColors.primaryBlue),
              const SizedBox(height: 24),
              Text('Analyzing your profile...', style: AppTextStyles.h3),
              const SizedBox(height: 8),
              Text(
                'Our AI is finding the best career paths for you.',
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final currentQ = _quizData[_currentQuestionIndex];
    final options = (currentQ["options"] as List)
        .map((e) => Map<String, String>.from(e))
        .toList();
    final totalQuestions = _quizData.length;
    final progress = (_currentQuestionIndex + 1) / totalQuestions;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'ASSESSMENT',
          style: AppTextStyles.bodySm.copyWith(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar Area
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentQuestionIndex + 1}/$totalQuestions',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.surfaceLight,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryBlue,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      currentQ["question"] as String,
                      style: AppTextStyles.h2.copyWith(height: 1.3),
                    ),
                    const SizedBox(height: 24),

                    // Image Placeholder
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryBlue.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        currentQ["icon"] as IconData,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Options List
                    ...List.generate(options.length, (index) {
                      final option = options[index];
                      final isSelected = _selectedOptionIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOptionIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryBlueLight
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : AppColors.border,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      option["title"]!,
                                      style: AppTextStyles.bodyLg.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? AppColors.primaryBlue
                                            : AppColors.textMain,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      option["subtitle"]!,
                                      style: AppTextStyles.bodySm.copyWith(
                                        color: isSelected
                                            ? AppColors.primaryBlue.withOpacity(
                                                0.8,
                                              )
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primaryBlue
                                        : AppColors.border,
                                    width: 2,
                                  ),
                                  color: isSelected
                                      ? AppColors.primaryBlue
                                      : Colors.transparent,
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Action Area
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: _selectedOptionIndex != null ? _nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: AppColors.surfaceLight,
                  disabledForegroundColor: AppColors.textLight,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentQuestionIndex < totalQuestions - 1
                          ? 'Next Question'
                          : 'Finish Quiz',
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
