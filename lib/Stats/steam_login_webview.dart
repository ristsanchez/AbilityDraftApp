import 'package:flutter/material.dart';
import 'package:steam_login/steam_login.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  String steamId = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steam Login'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text('Login'),
              onPressed: () async {
                // Navigate to the login page.
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SteamLogin()));
                setState(() {
                  steamId = result;
                });
              },
            ),
            Text('Steamid: $steamId'),
          ],
        ),
      ),
    );
  }
}

class SteamLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Listen to the onUrlChanged events, and when we are ready to validate do so.

    var openId = OpenId.raw('https://myapp', 'https://myapp', {});
  }
}
