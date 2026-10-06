class ProfileModel {
  final String name;
  final String title;
  final String tagline;
  final String email;
  final String phone;
  final String location;
  final String github;
  final String linkedin;

  final String avatarPath;

  const ProfileModel({
    required this.name,
    required this.title,
    required this.tagline,
    required this.email,
    required this.phone,
    required this.location,
    required this.github,
    required this.linkedin,
    this.avatarPath = 'assets/images/profile.jpg',
  });

  static const ProfileModel instance = ProfileModel(
    name: 'Srividya Divvi',
    title: 'B.Tech AI & DS Student & Aspiring Developer',
    tagline: 'Crafting intelligent digital experiences with passion and precision.',
    email: 'srividya.divvi@example.com',
    phone: '+91 **********',
    location: 'Andhra Pradesh, India',
    github: 'https://github.com/divviprameela-ui/',
    linkedin: 'linkedin.com/in/srividya-divvi',
    avatarPath: 'assets/images/profile.jpg',
  );
}
