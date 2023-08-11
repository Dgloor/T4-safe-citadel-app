import 'package:flutter/material.dart';

import 'package:safecitadel/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "¿Olvidaste tu contraseña?",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Por favor, comunicarse con la administración de Samanes 7 para brindarle ayuda.",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

// class ForgotPassForm extends StatefulWidget {
//   const ForgotPassForm({super.key});

//   @override
//   _ForgotPassFormState createState() => _ForgotPassFormState();
// }

// class _ForgotPassFormState extends State<ForgotPassForm> {
//   final _formKey = GlobalKey<FormState>();
//   List<String> errors = [];
//   String? email;
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             onSaved: (newValue) => email = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty && errors.contains(kUsernameNullError)) {
//                 setState(() {
//                   errors.remove(kUsernameNullError);
//                 });
//               } else if (emailValidatorRegExp.hasMatch(value) &&
//                   errors.contains(kInvalidEmailError)) {
//                 setState(() {
//                   errors.remove(kInvalidEmailError);
//                 });
//               }
//               return;
//             },
//             validator: (value) {
//               if (value!.isEmpty && !errors.contains(kUsernameNullError)) {
//                 setState(() {
//                   errors.add(kUsernameNullError);
//                 });
//               } else if (!emailValidatorRegExp.hasMatch(value) &&
//                   !errors.contains(kInvalidEmailError)) {
//                 setState(() {
//                   errors.add(kInvalidEmailError);
//                 });
//               }
//               return null;
//             },
//             decoration: const InputDecoration(
//               labelText: "Email",
//               hintText: "Enter your email",
//               // If  you are using latest version of flutter then lable text and hint text shown like this
//               // if you r using flutter less then 1.20.* then maybe this is not working properly
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//               suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
//             ),
//           ),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           FormError(errors: errors),
//           SizedBox(height: SizeConfig.screenHeight * 0.1),
//           DefaultButton(
//             text: "Continuar",
//             press: () {
//               if (_formKey.currentState!.validate()) {
//                 // Do what you want to do
//               }
//             },
//           ),
//           SizedBox(height: SizeConfig.screenHeight * 0.1),
//           const NoAccountText(),
//         ],
//       ),
//     );
//   }
// }
