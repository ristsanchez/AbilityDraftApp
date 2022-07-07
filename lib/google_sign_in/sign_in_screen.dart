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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: clearContainer2(const Center()),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 105, 0, 100),
                  height: 130.0,
                  width: 130.0,
                  child: Image.asset(
                    'assets/tm/dota_logo.png',
                    fit: BoxFit.cover,
                    color: const Color(0xFFA72714),
                    colorBlendMode: BlendMode.srcATop,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 5,
                      bottom: 90,
                      left: 35,
                      right: 35,
                    ),
                    child: clearContainer(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
                            alignment: Alignment.center,
                            height: 180,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Login",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "Sign in to continue",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 54, right: 54),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(10),
                              child: MaterialButton(
                                height: 50,
                                color: Colors.white,
                                elevation: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const VerticalDivider(
                                      width: 1,
                                    ),
                                    Container(
                                      height: 34.0,
                                      width: 34.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/tm/google_logo.png'),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const VerticalDivider(
                                      width: 8,
                                    ),
                                    const Text(
                                      "Sign In with Google",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),

                                // by onpressed we call the function signup function
                                onPressed: () async {
                                  await signup(context);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(54, 0, 54, 0),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(10),
                              child: MaterialButton(
                                height: 50,
                                color: const Color(0xFF2a475e),
                                elevation: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    VerticalDivider(
                                      width: 2,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.steam,
                                      size: 34,
                                    ),
                                    VerticalDivider(
                                      width: 10,
                                    ),
                                    Text(
                                      "Sign in with Steam",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),

                                // by onpressed we call the function signup function
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyHomePage()));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 54, right: 54, top: 40),
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Just browsing? ",
                                    style: TextStyle(
                                        color: Colors.white60, fontSize: 12),
                                  ),
                                  Text(
                                    "Skip sign in",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyHomePage()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
          initialPage: ((i * 2) % 30), //isEven ? i : 30 - i,
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
