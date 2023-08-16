class User {
  final String id;
  final String name;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.role,
  });
  //desde un api crear un usuario
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      role: json['role'],
    );
  }

}
const String description =
    "Usuario de safecitadel";

class UserSingleton {
  static User user = User(id: '', name: "", role: "");
  static bool isGUARD() {
    return user.role == "GUARD";
  }
  
}
