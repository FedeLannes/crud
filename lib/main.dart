// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:crud/pages/list_pages.dart';
import 'package:crud/pages/save_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: ListPage.ROUTE,
      routes: {
        ListPage.ROUTE: (_) => ListPage(),
        SavePage.ROUTE: (_) => SavePage(),
      },
    );
  }
}
