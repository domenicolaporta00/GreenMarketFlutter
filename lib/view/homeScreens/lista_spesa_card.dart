import 'package:flutter/material.dart';
import 'package:green_market_flutter/view/conferma_ordine.dart';
import 'package:green_market_flutter/viewModel/home/lista_spesa_view_model.dart';
import 'package:provider/provider.dart';

import '../../model/product_in_shopping_list_model.dart';
import '../../viewModel/dettaglio_prodotto_view_model.dart';
import '../dettaglio_prodotto.dart';

class ListaSpesaCard extends StatefulWidget {
  const ListaSpesaCard({super.key});

  @override
  State<ListaSpesaCard> createState() => _ListaSpesaCardState();
}

class _ListaSpesaCardState extends State<ListaSpesaCard> {
  late Future<List<ProductInShoppingList>> futureProdotti;

  @override
  void initState() {
    super.initState();
    //Devo assegnare un valore a futureProdotti prima che venga instanziato il WidgetsBinding
    futureProdotti = Future.value([]);
    //Assegna la lista dei prodotti dopo che la UI è stata completamente aggiornata
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final listaSpesaViewModel = Provider.of<ListaSpesaViewModel>(context, listen: false);
      futureProdotti = listaSpesaViewModel.getListaDellaSpesa();
    });

  }

  @override
  Widget build(BuildContext context) {
    final listaSpesaViewModel = Provider.of<ListaSpesaViewModel>(context);
    final dettaglioProdottoViewModel = Provider.of<DettaglioProdottoViewModel>(context);

    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<ProductInShoppingList>>(
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
                        final prodottoInLista = items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.green, width: 2.0),
                            ),
                            child: ListTile(
                              onTap: () async {
                                await listaSpesaViewModel.getProdottoByNome(prodottoInLista);
                                dettaglioProdottoViewModel.setQuantita(prodottoInLista.quantita);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DettaglioProdotto(
                                      prodotto: listaSpesaViewModel.prodottoDettagliato,
                                    ),
                                  ),
                                );
                              },
                              title: Text("${items[index].nome} €${items[index].prezzoAlKg}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Quantità: ${items[index].quantita}kg"),
                                  Text("Prezzo totale: €${items[index].prezzoTotale}"),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () async{
                                  await listaSpesaViewModel.deleteByName(prodottoInLista.nome);
                                },
                                icon: const Icon(Icons.delete, color: Colors.red),
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
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (listaSpesaViewModel.listaProdotti.isEmpty) {
                              listaSpesaViewModel.showSnackBar("Lista della spesa vuota", context);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfermaOrdine(totale: listaSpesaViewModel.totale),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Riepilogo ordine"),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      FloatingActionButton(
                        onPressed: () async {
                          if(listaSpesaViewModel.listaProdotti.isEmpty){
                            listaSpesaViewModel.showSnackBar("Lista della spesa vuota", context);
                          }else{
                            await listaSpesaViewModel.deleteListaSpesa(); // Attendo il completamento
                            listaSpesaViewModel.showSnackBar("Lista della spesa cancellata", context);
                            // Aggiorno l'UI solo dopo che la cancellazione è stata completata
                            listaSpesaViewModel.getListaDellaSpesa(); // Chiamata per riottenere la lista aggiornata
                          }
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
