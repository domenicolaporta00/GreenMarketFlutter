import 'package:flutter/material.dart';
import 'package:green_market_flutter/view/conferma_ordine.dart';
import 'package:green_market_flutter/viewModel/home/lista_spesa_view_model.dart';
import 'package:provider/provider.dart';

class ListaSpesaCard extends StatefulWidget {
  const ListaSpesaCard({super.key});

  @override
  State<ListaSpesaCard> createState() => _ListaSpesaCardState();
}

class _ListaSpesaCardState extends State<ListaSpesaCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final listaSpesaViewModel = Provider.of<ListaSpesaViewModel>(context, listen: false);
      listaSpesaViewModel.getListaSpesa();
      listaSpesaViewModel.getTotale();
    });
  }

  @override
  Widget build(BuildContext context) {
    final listaSpesaViewModel = Provider.of<ListaSpesaViewModel>(context);

    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listaSpesaViewModel.listaProdotti.length,
                itemBuilder: (context, index) {
                  final prodottoInLista = listaSpesaViewModel.listaProdotti[index];
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
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DettaglioProdotto(prodotto: prodotto)
                            ),
                          );*/
                        },
                        title: Text("${prodottoInLista.nome} €${prodottoInLista.prezzo}" ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Quantità: ${prodottoInLista.quantita}kg"),
                            Text("Prezzo totale: €${prodottoInLista.prezzoTotale}"),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            listaSpesaViewModel.showSnackBar(prodottoInLista.nome, context);
                            listaSpesaViewModel.deleteByName(prodottoInLista.nome);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Totale: €",
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${listaSpesaViewModel.totale}",
                          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){
                            if(listaSpesaViewModel.listaProdotti.isEmpty) {
                              listaSpesaViewModel.showSnackBar("Lista della spesa vuota", context);
                            }
                            else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfermaOrdine(totale: listaSpesaViewModel.totale)
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white
                          ),
                          child: const Text("Riepilogo ordine"),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      FloatingActionButton(
                        onPressed: () {
                          listaSpesaViewModel.deleteListaSpesa();
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
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
