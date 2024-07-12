import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/viewModel/conferma_ordine_view_model.dart';
import 'package:green_market_flutter/viewModel/dettaglio_prodotto_view_model.dart';
import 'package:green_market_flutter/viewModel/home/home_page_view_model.dart';
import 'package:green_market_flutter/viewModel/home/lista_spesa_view_model.dart';
import 'package:green_market_flutter/viewModel/home/profilo_view_model.dart';
import 'package:green_market_flutter/viewModel/home/ricerca_view_model.dart';

import 'splash_screen.dart';

import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
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
        ChangeNotifierProvider(
          create: (context)=>DettaglioProdottoViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context)=>ConfermaOrdineViewModel(),
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
      title: 'GreenMarket Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MySplashScreen(),
    );
  }
}