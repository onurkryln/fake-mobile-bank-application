import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yenivhatsapp/animation.dart';

import 'Entityy/hesap.dart';

void main()async {WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
runApp((MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(),home: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Animationpage();
  }
}
