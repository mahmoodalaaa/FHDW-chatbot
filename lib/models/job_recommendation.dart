class JobRecommendation {
  final String jobTitle;
  final String description;
  final int matchPercentage;
  final String salary;
  final String growth;
  final List<DailyTask> dailyTasks;

  JobRecommendation({
    required this.jobTitle,
    required this.description,
    required this.matchPercentage,
    required this.salary,
    required this.growth,
    required this.dailyTasks,
  });

  factory JobRecommendation.fromJson(Map<String, dynamic> json) {
    return JobRecommendation(
      jobTitle: json['jobTitle'] ?? 'Unknown Job',
      description: json['description'] ?? '',
      matchPercentage: json['matchPercentage'] ?? 0,
      salary: json['salary'] ?? 'N/A',
      growth: json['growth'] ?? 'N/A',
      dailyTasks:
          (json['dailyTasks'] as List<dynamic>?)
              ?.map((task) => DailyTask.fromJson(task as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory JobRecommendation.mock() {
    return JobRecommendation(
      jobTitle: 'UX Designer',
      description:
          'UX Designers focus on the interaction between real human users and everyday products and services.',
      matchPercentage: 95,
      salary: '\$95k/yr',
      growth: '+13%',
      dailyTasks: [
        DailyTask(
          time: '09:00 AM',
          title: 'User Research',
          description: 'Analyzing user feedback and conducting interviews.',
        ),
      ],
    );
  }
}

class DailyTask {
  final String time;
  final String title;
  final String description;

  DailyTask({
    required this.time,
    required this.title,
    required this.description,
  });

  factory DailyTask.fromJson(Map<String, dynamic> json) {
    return DailyTask(
      time: json['time'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
