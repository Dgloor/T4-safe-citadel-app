class User {
  final int id;
  final String nombre;
  final String image;


  User({
    required this.id,
    required this.image,
    required this.nombre,
  });
}


List<User> demoUsers = [
  User(
    id: 1,
    image: 
      "assets/images/profile.png",
     nombre: "Juan",
  ),
  User(
    id: 2,
    image: 
      "assets/images/profile.png",
     nombre: "Juan",
),
  User(
    id: 3,
     image: 
      "assets/images/profile.png",
     nombre: "Juan",
),
  User(
    id: 4,
    image: 
      "assets/images/profile.png",
     nombre: "Juan",
),
];

const String description =
    "Usuario de prueba";