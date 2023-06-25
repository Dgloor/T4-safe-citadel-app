class User {
  final String id;
  final String name;
  final String? image;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.role,
    this.image,
  });
  //desde un api crear un usuario
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['nombre'],
      role: json['role'],
      image: json['image'],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'nombre': nombre,
  //     'fechaVisita': fechaVisita.toString(),
  //     'fechaCreacion': fechaCreacion.toString(),
  //     'residente': residente,
  //   };
  // }

  // String toJson() {
  //   return jsonEncode(toMap());
  // }
}


List<User> demoUsers = [
  User(
    id: "1",
    image: 
      "assets/images/profile.png",
     name: "Juan",
    role: "RESIDENTE"
  ),
  User(
    id: "2",
    image: 
      "assets/images/profile.png",
     name: "Juan",
     role: "RESIDENTE"
),
  User(
    id: "3",
     image: 
      "assets/images/profile.png",
     name: "Juan",
     role: "RESIDENTE"
),
  User(
    id: "4",
    image: 
      "assets/images/profile.png",
     name: "Juan",
     role: "RESIDENTE"
),
];

const String description =
    "Usuario de prueba";
class UserSingleton {
  static User user=
      User(
    id: "1",
    image: 
      "assets/images/profile.png",
     name: "PRUEBA",
    role: "RESIDENTE"
  ) ;
}