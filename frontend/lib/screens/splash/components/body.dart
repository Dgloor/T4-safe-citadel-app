import 'package:flutter/material.dart';
import 'package:safecitadel/constants.dart';
import 'package:safecitadel/screens/sign_in/sign_in_screen.dart';
import 'package:safecitadel/size_config.dart';

// This is the best practice
import '../../../utils/Persistence.dart';
import '../../home/home_screen.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Bienvenido a SafeCitadel",
      "image": "assets/images/logo.png"
    },
    {
      "text":
          "Tu ciudadela cada vez más segura",
      "image": "assets/images/img1.jpg"
    },
    {
      "text": "Administre sus visitas de manera más eficiente",
      "image": "assets/images/img2.jpg"
    },
  ];
  @override
  void initState() {
    super.initState();
    checkUserIsLogged();
  }


  void checkUserIsLogged() async {
  final apiClient = ApiGlobal.api;

  String? token = await apiClient.getToken();

  if (token != null) {
    String? username = await apiClient.getUserName();
    String? password = await apiClient.getPassWord();

    if (username != null && password != null) {
      try {
        final response = await apiClient.authenticate(username, password, context);
        
        if (response != null) {
          Navigator.pushNamed(context, HomeScreen.routeName);
        } else {
          // Handle authentication failure if necessary
        }
      } catch (error) {
        // Handle authentication error if necessary
      }
    } else {
      // Handle missing username or password
    }
  } else {
    // Handle token being null
  }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      key: Key("continueButton"),
                      text: "Continuar",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
