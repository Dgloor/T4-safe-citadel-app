import 'package:flutter/widgets.dart';
import 'package:prueba/screens/cart/cart_screen.dart';
import 'package:prueba/screens/complete_profile/complete_profile_screen.dart';
import 'package:prueba/screens/details/details_screen.dart';
import 'package:prueba/screens/forgot_password/forgot_password_screen.dart';
import 'package:prueba/screens/home/home_screen.dart';
import 'package:prueba/screens/otp/otp_screen.dart';
import 'package:prueba/screens/profile/profile_screen.dart';
import 'package:prueba/screens/qr_reader/qr_reader_screen.dart';
import 'package:prueba/screens/register/register_screen.dart';
import 'package:prueba/screens/sign_in/sign_in_screen.dart';
import 'package:prueba/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  QRScreen.routeName: (context) => const QRScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
};
