class JourneyModel {
  final String degree;
  final String institution;
  final String duration;
  final String grade;

  const JourneyModel({
    required this.degree,
    required this.institution,
    required this.duration,
    required this.grade,
  });

  static const List<JourneyModel> educationList = [
    JourneyModel(
      degree: "B.Tech in Artificial Intelligence & Data Science (AI & DS)",
      institution: "Malineni Lakshmaiah Women's Engineering College",
      duration: "2026 - Present",
      grade: "8.7 CGPA",
    ),
    JourneyModel(
      degree: "Intermediate (MPC)",
      institution: "Sri Chaitanya Junior College",
      duration: "2022 - 2024",
      grade: "78%",
    ),
    JourneyModel(
      degree: "Secondary School Certificate (SSC)",
      institution: "High School",
      duration: "2021 - 2022",
      grade: "77%",
    ),
  ];
}