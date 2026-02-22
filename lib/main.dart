import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/app_state.dart';
import 'screens/onboarding_screen.dart';
import 'theme/app_colors.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppState())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FHDW AI Chatbot',
      theme: ThemeData(
        primaryColor: AppColors.primaryBlue,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.textMain),
          titleTextStyle: TextStyle(
            color: AppColors.textMain,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: AppColors.textWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                24,
              ), // Adjusted towards design
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            elevation: 0,
          ),
        ),
      ),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
