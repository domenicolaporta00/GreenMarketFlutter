import 'package:flutter/material.dart';
import 'package:green_market_flutter/viewModel/home/home_page_view_model.dart';
import 'package:green_market_flutter/viewModel/home/lista_spesa_view_model.dart';
import 'package:green_market_flutter/viewModel/home/profilo_view_model.dart';
import 'package:green_market_flutter/viewModel/home/ricerca_view_model.dart';

import 'splash_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context)=>HomePageViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context)=>RicercaViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context)=>ListaSpesaViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context)=>ProfiloViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenMarket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MySplashScreen(),
    );
  }
}

