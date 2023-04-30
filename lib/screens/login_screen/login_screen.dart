import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kta_official/components/custom_buttons.dart';
import 'package:kta_official/constants.dart';
import 'package:kta_official/screens/admition_screen/admission_screen.dart';
import 'package:kta_official/screens/home_screen/home_screen.dart';
import 'package:http/http.dart' as http;

late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  static String routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // chnages current state
  @override
  void initState() {
    //  TODO: implement initState
    super.initState();
    _passwordVisible = true;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, call a function to validate the email and password
      _validateUser(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // when user types anywhere on the screen,keyboard hides
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            //  divide the body into two halves
            Container(
              // use media query to fit all screens sizes in same manner
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/kta_logo.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hi',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w200)),
                      SizedBox(width: 8),
                      Text(
                        'Student',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                  SizedBox(height: kDefaultPadding / 6),
                  Text('Sign in to continue',
                      style: Theme.of(context).textTheme.subtitle2),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kDefaultPadding * 3),
                  topRight: Radius.circular(kDefaultPadding * 3),
                ),
                color: kOtherColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          // this is the best practice for clean code
                          buildEmailField(),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          buildPasswordField(),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          DefaultButton(
                            onPress: () {
                              _submitForm();
                              // if (_formKey.currentState!.validate()) {
                              //   //  go to next activity
                              //   // Navigator.pushNamedAndRemoveUntil(context,
                              //   //     HomeScreen.routeName, (route) => false);
                              // }
                            },
                            title: "SIGN IN",
                            iconData: Icons.arrow_forward_outlined,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Forgot Password',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: kPrimaryColor, fontSize: 15.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text("If you are not registered, do Sign Up"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdmissionScreen()),
                                  );
                                },
                                child: Text("SIGN UP"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: _emailController,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          color: kTextBlackColor, fontSize: 17.0, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        labelText: "Mobile Number/Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
      ),
      validator: (value) {
        // for validation
        RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return "Please enter some text";
          //  if it doesnot matches the pattern like, it not containes @
        } else if (!regExp.hasMatch(value)) {
          return "Please enter a valid email address";
        }
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(
          color: kTextBlackColor, fontSize: 17.0, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(_passwordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_off_outlined),
          iconSize: kDefaultPadding,
        ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return "Must be more than 5 chanacters";
        }
      },
    );
  }

  void _validateUser(String email, String password) async {
    // Make an API call to your backend server to validate the user's credentials
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('RegisteredStudents');
      final QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot userDoc = querySnapshot.docs.first;
        final String hashedPassword = userDoc.get('password');
        final bool isPasswordCorrect = BCrypt.checkpw(password, hashedPassword);
        if (isPasswordCorrect) {
          print("User logged in");
          // Navigate to the next screen after successful login
          // Pass user data to the HomeScreen after successful login

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                    name: userDoc.get('name'),
                    email: userDoc.get('email'),
                    phone: userDoc.get('phone'),
                    age: userDoc.get('age'),
                    profilePic: userDoc.get('profilePic'),
                    joiningDate: userDoc.get('joiningDate'),
                    selectedBranch: userDoc.get('selectedBranch'),
                    id: userDoc.get("id"))),
            (route) => false,
          );
        } else {
          print("Incorrect password");
          // Show an error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Incorrect Password!.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        print("User not found");
        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User Not Found!.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print("Failed to login user: $error");
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to login user!.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
