import 'package:flutter/material.dart';
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
            child: Column(
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
                      "Raj",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                )
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
