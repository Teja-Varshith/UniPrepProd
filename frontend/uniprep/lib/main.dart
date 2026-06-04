import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uniprep/firebase_options.dart';

void main() async{

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  build(BuildContext context) {
    return MaterialApp(
      title: 'UniPrep',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'UniPrep Home Page'),
    );
  }}