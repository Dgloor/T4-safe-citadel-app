import 'package:flutter/material.dart';
import 'package:prueba/components/form_error.dart';
import 'package:prueba/helper/keyboard.dart';
import 'package:prueba/screens/forgot_password/forgot_password_screen.dart';
import 'package:prueba/screens/home/home_screen.dart';
import 'package:prueba/utils/Persistence.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:prueba/utils/Persistencia.dart';
import 'package:prueba/models/User.dart';

class SignForm extends StatelessWidget {
  late SharedPreferencesUtil prefsUtil;

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  String _errorMessage = '';
  final List<String?> errors = [];

  SignForm({super.key});
  @override
  void initState() {
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    prefsUtil = await SharedPreferencesUtil.getInstance();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({String? error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        buildEmailFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        buildPasswordFormField(),
        SizedBox(height: getProportionateScreenHeight(30)),
        Row(
          children: [
            Checkbox(
              value: remember,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                remember = value;
              },
            ),
            const Text("Recordarme"),
            const Spacer(),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
              child: const Text(
                "Olvidé mi contraseña",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        FormError(errors: errors),
        SizedBox(height: getProportionateScreenHeight(20)),
        DefaultButton(
          press: () {
            final apiClient = ApiGlobal.api;
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // if all are valid then go to success screen
              KeyboardUtil.hideKeyboard(context);
            }
            apiClient.authenticate(email, password).then((_) {
              apiClient.getUserData().then((userData) {
                UserSingleton.user = userData;
                Future.delayed(const Duration(seconds: 4), () {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                });
              }).catchError((error) {
                _errorMessage = error.toString();
              });
            }).catchError((error) {
              _errorMessage = error.toString();
            });
          },
          text: 'Iniciar sesión',
        ),
        if (_errorMessage.isNotEmpty)
          Text(
            _errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
      ]),
    );
  }

  TextFormField buildPasswordFormField() {
    bool passToggle = false;
    return TextFormField(
      obscureText: !passToggle,
      enableInteractiveSelection: false,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 7) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 7) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingrese su contraseña",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        // else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kInvalidEmailError);
        // }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        // else if (!emailValidatorRegExp.hasMatch(value)) {
        //   addError(error: kInvalidEmailError);
        //   return "";
        // }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Usuario",
        hintText: "Ingrese su usuario",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.person),
      ),
    );
  }
}
