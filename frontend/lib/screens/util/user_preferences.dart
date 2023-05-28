import 'package:prueba/model/user.dart';

class UserPreferences {
  static const myUser = User(
    imagePath:
        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
    name: 'Juan',
    email: 'joshkm6@gmail.com',
    about: 'Hola, soy Juan',
    isDarkMode: false,
    superUser: false,
  );
}