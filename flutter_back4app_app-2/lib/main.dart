
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyAppId = 'vsuXOGSA6T1MrIg4NFGSROHxnsjg8RxTSoTeYjuO';
  const keyClientKey = 'kpcNH6YuFG4Awim0zuEB919N9N0PMsN5DCmnltk9';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyAppId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back4App Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthPage(),
    );
  }
}
