import 'package:flutter/material.dart';
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
                          ricercaViewModel.showSnackBar("Cliccato ${prodotto.nome}", context);
                        },
                        title: Text(prodotto.nome),
                        subtitle: Text("€${prodotto.prezzo}"),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:  const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                          color: Colors.green
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: ricercaTextEditController,
                        decoration: InputDecoration(
                          hintText: 'Inserisci qualcosa...',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            )
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
