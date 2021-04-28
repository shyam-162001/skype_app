import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skype_app/provider/user_provider.dart';

import 'package:skype_app/resources/firebase_repository.dart';
import 'package:skype_app/screens/home_screen.dart';
import 'package:skype_app/screens/login_screen.dart';
import 'package:skype_app/screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseRepository _repository = FirebaseRepository();
  @override
  Widget build(BuildContext context) {
    //  _repository.signOut();
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
          title: "Skype Clone",
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {'/search_screen': (context) => SearchScreen()},
          theme: ThemeData(brightness: Brightness.dark),
          home: FutureBuilder(
              future: _repository.getCurrentUser(),
              builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                if (snapshot.hasData) {
                  return HomeScreen();
                } else {
                  return LoginScreen();
                }
              })),
    );
  }
}
