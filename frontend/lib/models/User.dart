class User {
  final int id;
  final String name;
  final String image;


  User({
    required this.id,
    required this.image,
    required this.name,
  });
}


List<User> demoUsers = [
  User(
    id: 1,
    image: 
      "assets/images/profile.png",
     name: "Juan",
  ),
  User(
    id: 2,
    image: 
      "assets/images/profile.png",
     name: "Juan",
),
  User(
    id: 3,
     image: 
      "assets/images/profile.png",
     name: "Juan",
),
  User(
    id: 4,
    image: 
      "assets/images/profile.png",
     name: "Juan",
),
];

const String description =
    "Usuario de prueba";