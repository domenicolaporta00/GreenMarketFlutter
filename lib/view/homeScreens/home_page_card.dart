import 'package:flutter/material.dart';
import 'package:green_market_flutter/viewModel/home/home_page_view_model.dart';
import 'package:provider/provider.dart';

import '../dettaglio_prodotto.dart';

class HomePageCard extends StatefulWidget {
  const HomePageCard({super.key});

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {

  TextEditingController emailTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homePageViewModel = Provider.of<HomePageViewModel>(context, listen: false);
      homePageViewModel.getNome();
      homePageViewModel.updateStatus();
      homePageViewModel.getProdottiRandom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomePageViewModel>(context);

    Theme.of(context);
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "images/ic_launcher.png",
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Ciao ${homeViewModel.nome} \u{1F44B}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        homeViewModel.status,
                        style: TextStyle(
                          color: homeViewModel.colore,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        homeViewModel.orari,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  const Text(
                    "Prodotti in evidenza",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Numero di colonne
                  mainAxisSpacing: 8.0, // Spaziatura verticale tra gli elementi
                  crossAxisSpacing: 8.0, // Spaziatura orizzontale tra gli elementi
                  childAspectRatio: 0.75, // Rapporto d'aspetto per ogni elemento (puoi regolarlo come necessario)
                ),
                itemCount: homeViewModel.listaProdotti.length,
                itemBuilder: (context, index) {
                  final prodotto = homeViewModel.listaProdotti[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4.0,
                      color: Colors.white,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DettaglioProdotto(prodotto: prodotto)
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  prodotto.foto,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      prodotto.nome,
                                      style: const TextStyle(
                                          fontSize: 16.0
                                      ),
                                    ),
                                    Text(
                                      "€${prodotto.prezzo}",
                                      style: const TextStyle(
                                          fontSize: 16.0
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
