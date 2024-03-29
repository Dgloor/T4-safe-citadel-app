import 'package:flutter/material.dart';
import 'package:safecitadel/size_config.dart';

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
const String kUsernameNullError = "Por favor ingrese su usuario";
const String kInvalidEmailError = "Usuario no valido";
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
    borderSide: const BorderSide(color: kTextColor),
  );
}
final buttonStyle= ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor), // Cambia el color de fondo del botón
    // Otros estilos opcionales que puedes personalizar:
    // foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambia el color del texto del botón
    side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: Colors.green)), // Cambia el estilo de borde
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)), // Cambia el relleno interno del botón
    // textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 20)), // Cambia el estilo del texto del botón
  );

const url = 'https://www.safecitadelgye.com';
const String APIAUTH =  url+"/api/login/";
const String APIUSER =  url+"/api/user/";
const String APIPOSTVISIT = url+"/api/visit/";
const String APIGETVISITS =  url+"/api/user/visit";
const String APIQR =  url+"/api/qr/";
const String APIREGISTER =  url+"/api/visit/register?qr_id=";
const String APICANCEL =  url+"/api/visit/cancel?qr_id=";
const String APIGETVISIT = url+"/api/visit/";
const String APIPOSTPASSWORD = url+"/api/user/update-password";
const String APIREFRESHTOKEN = url+"/api/refresh?token=";
