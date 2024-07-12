import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/view/dettaglio_prodotto.dart';
import 'package:green_market_flutter/viewModel/home/ricerca_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/product_model.dart';


class RicercaCard extends StatefulWidget {
  const RicercaCard({Key? key}) : super(key: key);

  @override
  _RicercaCardState createState() => _RicercaCardState();
}

class _RicercaCardState extends State<RicercaCard> {
  TextEditingController ricercaTextEditController = TextEditingController();
  late Future<List<ProductModel>> futureProdotti;


  @override
  void initState() {
    super.initState();
    final ricercaViewModel = Provider.of<RicercaViewModel>(context, listen: false);
    futureProdotti = ricercaViewModel.getProdotti();
  }

  void searchProdotti() {
    setState(() {
      final ricercaViewModel = Provider.of<RicercaViewModel>(context, listen: false);
      futureProdotti = ricercaViewModel.getProdottoByNome(nome: ricercaTextEditController.text.trim());
    });
  }

  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ricercaViewModel = Provider.of<RicercaViewModel>(context, listen: false);
      ricercaViewModel.getProdotti();
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final ricercaViewModel = Provider.of<RicercaViewModel>(context);

    return Card(
      shadowColor: Colors.transparent,
      child: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: futureProdotti,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final items = snapshot.data!;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        //final prodotto = ricercaViewModel.listaProdotti?[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.green, width: 2.0),
                            ),
                            child: ListTile(
                              onTap: () {
                                //ricercaViewModel.showSnackBar("Cliccato ${prodotto.nome}", context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DettaglioProdotto(prodotto: items[index])
                                  ),
                                );
                              },
                              title: Text(items[index].nome),
                              subtitle: Text("€${items[index].prezzo}"),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          items[index].foto,
                                        ),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No data'));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: ricercaTextEditController,
                      decoration: InputDecoration(
                        hintText: 'Inserisci qualcosa...',
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.green,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.green,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            String nomeProdotto = ricercaTextEditController.text.trim();
                            searchProdotti();
                          },
                          child: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FloatingActionButton(
                    onPressed: () {
                      ricercaViewModel.getProdotti();
                      ricercaTextEditController.text = "";
                    },
                    child: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
