import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uniprep/features/auth/loginScreen.dart';
import 'package:uniprep/features/home/home_screen.dart';

final loggedOutRoutes = RouteMap(routes: {
  "/": (_) => MaterialPage(child: LoginScreen()),
});

final loggedInRoutes = RouteMap(routes: {
  "/": (_) => MaterialPage(child: HomeScreen()),
});