class UserProfile {
  String name;
  String email;
  String bio;

  UserProfile({required this.name, required this.email, required this.bio});
}

class ChatMessage {
  String text;
  bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class CareerMatch {
  String title;
  int percentage;
  String description;

  CareerMatch({required this.title, required this.percentage, required this.description});
}
