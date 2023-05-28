class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool superUser;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
    required this.superUser
  });
}