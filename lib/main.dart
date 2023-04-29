import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:kta_official/constants.dart';
import 'package:kta_official/routes.dart';
import 'package:kta_official/screens/splash_screen/splash_screen.dart';

void main() async {
  // Initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KTA",
      // we will use light theme for our app
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.blueAccent,
          primaryColor: Colors.blueAccent,
          //use google fonts for our app, we will use sourceSansPro
          textTheme:
              GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme)
                  .apply()
                  .copyWith(
                    //  custom text for bodytext1
                    bodyText1: TextStyle(
                        color: kTextWhiteColor,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold),
                    // bodyText2: TextStyle(
                    //   color: kTextWhiteColor,
                    //   fontSize: 28.0,
                    // ),
                    subtitle1: TextStyle(
                        color: kTextBlackColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300),
                    subtitle2: TextStyle(
                        color: kTextWhiteColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300),
                  ),

          // input decoration theme for all over the app
          inputDecorationTheme: InputDecorationTheme(
            // label style for form feild
            labelStyle:
                TextStyle(fontSize: 15.0, color: kTextLightColor, height: 0.5),
            // hintStyle
            hintStyle:
                TextStyle(fontSize: 16.0, color: kTextBlackColor, height: 0.5),
            // we are using underline input border not outline
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kTextLightColor, width: 0.7),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: kTextLightColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kTextLightColor),
            ),
            // on focus change color
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor, width: 0.7),
            ),
            // colo chnages when user eneters wrong information, we will use validators fo this process
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kErrorBorderColor, width: 1.2),
            ),
            // same on foucus error color
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kErrorBorderColor, width: 1.2),
            ),
          )),
      // initial route is splash screen
      initialRoute: SplashScreen.routeName,
      // define the routes file here in order to acces the routes any where in the app
      routes: routes,
    );
  }
}
