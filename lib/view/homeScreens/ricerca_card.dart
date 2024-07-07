import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/view/dettaglio_prodotto.dart';
import 'package:green_market_flutter/viewModel/home/ricerca_view_model.dart';
import 'package:provider/provider.dart';


class RicercaCard extends StatefulWidget {
  const RicercaCard({Key? key}) : super(key: key);

  @override
  _RicercaCardState createState() => _RicercaCardState();
}

class _RicercaCardState extends State<RicercaCard> {
  TextEditingController ricercaTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ricercaViewModel = Provider.of<RicercaViewModel>(context, listen: false);
      ricercaViewModel.getListaProdotti();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ricercaViewModel = Provider.of<RicercaViewModel>(context);

    return Card(
      shadowColor: Colors.transparent,
      child: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: ricercaViewModel.listaProdotti.length,
                itemBuilder: (context, index) {
                  final prodotto = ricercaViewModel.listaProdotti[index];
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
                              builder: (context) => DettaglioProdotto(prodotto: prodotto)
                            ),
                          );
                        },
                        title: Text(prodotto.nome),
                        subtitle: Text("€${prodotto.prezzo}"),
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
                                    prodotto.foto,
                                  ),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                    ),
                  );
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
                            ricercaViewModel.getProdottoByNome(nomeProdotto, context);
                          },
                          child: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FloatingActionButton(
                    onPressed: () {
                      ricercaViewModel.getListaProdotti();
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
