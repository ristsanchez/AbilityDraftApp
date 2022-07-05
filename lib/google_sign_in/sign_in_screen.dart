import 'package:ability_draft/FrostWidgets/clear_container.dart';
import 'package:ability_draft/google_sign_in/google_authentication.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var mynum = Random().nextDouble() * 400;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: Stack(
          children: [
            getSome(context),
                  child: Image.asset(
                    'assets/tm/dota_logo.png',
                    fit: BoxFit.cover,
                    color: const Color(0xFFA72714),
                    colorBlendMode: BlendMode.srcATop,
                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: MaterialButton(
                        color: Colors.white,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 38.0,
                              width: 38.0,
                            ),
                            const SizedBox(
                              width: 20,
                    child: clearContainer(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 150,
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Sign In with Google",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),

                        // by onpressed we call the function signup function
                        onPressed: () async {
                          await signup(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: MaterialButton(
                        color: Color.fromARGB(255, 9, 60, 102),
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 38.0,
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
                            const Text("Sign in with Steam")
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: MaterialButton(
                        color: Colors.red,
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 38.0,
                              width: 30.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/stats_icons_small/hero_strength.png'),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const Text("Skip sign-in")
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getSome(BuildContext context) {
  List<Widget> yobeibi = [];
  bool isEven = true;

  int someMath = (MediaQuery.of(context).size.height / 56).floor();

  for (var i = 0; i < someMath - 1; i++) {
    yobeibi.add(
      CarouselSlider(
        items: getCarousellist(context),
        options: CarouselOptions(
          initialPage: isEven ? i : 30 - i,
          viewportFraction: 1,
          height: 50,
          autoPlayCurve: Curves.linear,
          autoPlayInterval: const Duration(seconds: 10),
          autoPlayAnimationDuration: const Duration(seconds: 10),
          autoPlay: true,
          aspectRatio: 1.78,
          enableInfiniteScroll: true,
          pageSnapping: false,
          reverse: isEven,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          pauseAutoPlayOnTouch: false,
          pauseAutoPlayOnManualNavigate: false,
          pauseAutoPlayInFiniteScroll: false,
        ),
      ),
    );
    yobeibi.add(const SizedBox(height: 7));
    isEven = !isEven;
  }
  yobeibi.add(const Expanded(
      child: Center(
          child: Text(
    'Dota 2 is a registered trademark of Valve Corporation. All game images are property of Valve Corporation',
    style: TextStyle(fontSize: 7, color: Colors.white60),
  ))));
  return Column(
    children: yobeibi,
  );
}

final int magicnm = 4;
getCarousellist(BuildContext context) {
  List<Widget> dirty = [];
  List<Widget> list = [];
  List names = context.watch<List?>()!;

  for (var i = 0; i < names.length; i += magicnm) {
    if (i > 119) {
      return list;
    }
    for (var j = i; j < i + magicnm; j++) {
      dirty.add(getPortImage(names[j], context));
    }
    list.add(Row(children: dirty));
    dirty = [];
  }
  return list;
}

getPortImage(String name, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: Image.asset(
      'assets/hero_portraits_big/$name.png',
      width: (MediaQuery.of(context).size.width - (4 * 2 * magicnm)) / magicnm,
      fit: BoxFit.cover,
    ),
  );
}
