import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vestago_task/home_screen.dart';
import 'package:vestago_task/track/view_models/tracking_provider.dart';

import 'dashboard/view_models/buyer_provider.dart';
import 'dashboard/view_models/crops_provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BuyerProvider()),
          ChangeNotifierProvider(create: (_) => CropsProvider()),
          ChangeNotifierProvider(create: (_) => TrackProvider())
        ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SafeArea(child:  HomeScreen()),
    );
  }
}

