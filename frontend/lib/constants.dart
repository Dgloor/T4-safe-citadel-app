import 'package:flutter/material.dart';
import 'package:prueba/size_config.dart';

const kPrimaryColor = Color(0xFF55A630);
const kPrimaryLightColor = Color(0xFFAACC00);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFBFD200), Color(0xFF55A630)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor ingrese su correo electrónico";
const String kInvalidEmailError = "Correo electronico no valido";
const String kPassNullError = "Ingrese su contraseña";
const String kShortPassError = "contraseña es demasiado corto";
const String kMatchPassError = "contraseña no coincide";
const String kNamelNullError = "Ingrese su nombre";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
final buttonStyle= ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor), // Cambia el color de fondo del botón
    // Otros estilos opcionales que puedes personalizar:
    // foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambia el color del texto del botón
    side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.green)), // Cambia el estilo de borde
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)), // Cambia el relleno interno del botón
    // textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 20)), // Cambia el estilo del texto del botón
  );

const String APIAUTH="https://safecitadel-d78923a86078.herokuapp.com/api/login/";
const String APIUSER="https://safecitadel-d78923a86078.herokuapp.com/api/user/";

