import 'package:ability_draft/google_sign_in/google_authentication.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var mynum = Random().nextDouble() * 400;
    return Scaffold(
      body: Center(
        child: Card(
          margin:
              const EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Goooooooo tigersssssssss!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: Colors.teal[100],
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/stats_icons_small/hero_agility.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text("Sign In with Google")
                    ],
                  ),

                  // by onpressed we call the function signup function
                  onPressed: () async {
                    await signup(context);
                  },
                ),
              ),
              MaterialButton(
                color: Colors.teal[100],
                elevation: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/stats_icons_small/hero_strength.png'),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("SKip")
                  ],
                ),

                // by onpressed we call the function signup function
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
