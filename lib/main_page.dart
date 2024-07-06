import 'package:flutter/material.dart';
import 'package:green_market_flutter/view/homeScreens/home_page_card.dart';
import 'package:green_market_flutter/view/homeScreens/lista_spesa_card.dart';
import 'package:green_market_flutter/view/homeScreens/ricerca_card.dart';
import 'package:green_market_flutter/view/homeScreens/profilo_card.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({super.key});

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("GreenMarket"),
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
      ),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.green,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Ricerca',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: 'Lista spesa',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profilo utente',
          ),
        ],
      ),

      body: <Widget>[
        const HomePageCard(),
        const RicercaCard(),
        const ListaSpesaCard(),
        const ProfiloCard()
      ][currentPageIndex],
    );
  }
}
