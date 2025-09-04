import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/detail_item_screen.dart';
import 'screens/order_screen.dart';
import 'screens/delivery_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/onboarding',
  routes: <RouteBase>[
    GoRoute(
      path: '/onboarding',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/detail_item',
      builder: (BuildContext context, GoRouterState state) {
        return const DetailItemScreen();
      },
    ),
    GoRoute(
      path: '/order',
      builder: (BuildContext context, GoRouterState state) {
        return const OrderScreen();
      },
    ),
    GoRoute(
      path: '/delivery',
      builder: (BuildContext context, GoRouterState state) {
        return const DeliveryScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.soraTextTheme(
          Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
