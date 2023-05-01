import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kta_official/constants.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // We will divide the screen into two different parts
          // fixed size for first half
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Hi",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontWeight: FontWeight.w200),
                            ),
                            Text(
                              "Rishi",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Text(
                          'Class X-II A | Roll no:12',
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontSize: 14.0,
                                  ),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Container(
                          width: 100,
                          height: 20,
                          decoration: BoxDecoration(
                            color: kOtherColor,
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                          ),
                          child: Center(
                            child: Text(
                              '2022-23',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: kTextBlackColor,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding / 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        // go to profile edit screen here
                      },
                      child: CircleAvatar(
                        minRadius: 50.0,
                        maxRadius: 50.0,
                        backgroundColor: kSecondaryColor,
                        backgroundImage:
                            AssetImage('assets/images/kta_logo.jpg'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        // go to attendence screen here
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          color: kOtherColor,
                          borderRadius: BorderRadius.circular(kDefaultPadding),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Attendence",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontSize: 16.0,
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "90.02%",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 25.0,
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // go to attendence screen here
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 5,
                        decoration: BoxDecoration(
                          color: kOtherColor,
                          borderRadius: BorderRadius.circular(kDefaultPadding),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Fees Due",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontSize: 16.0,
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '600\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      fontSize: 25.0,
                                      color: kTextBlackColor,
                                      fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // other will use all the remaining height of screen
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: kOtherColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding * 3),
                    topRight: Radius.circular(kDefaultPadding * 3),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                            onPress: () {},
                            icon: 'assets/icons/ask.svg',
                            title: 'New Events'),
    HomeCard(
    onPress: () {
    showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
    return GestureDetector(
    onTap: () {
    Navigator.pop(context);
    },
    child: Container(
    color: Colors.white,
    height: 100,
    child: Center(
    child: Text(
    "Fee status is currently unknown.",
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    );
    },
    );
    },
    icon: "assets/icons/indianRupeeNote.svg",
    title: 'Fees',
    ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {super.key,
      required this.onPress,
      required this.icon,
      required this.title});
  final VoidCallback onPress;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding / 2),
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 40.0,
              width: 40.0,
              // color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: kDefaultPadding / 3,
            ),
          ],
        ),
      ),
    );
  }
}
