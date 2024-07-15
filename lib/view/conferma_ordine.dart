import 'package:flutter/material.dart';
import 'package:green_market_flutter/viewModel/home/lista_spesa_view_model.dart';
import 'package:provider/provider.dart';

import '../viewModel/conferma_ordine_view_model.dart';
import '../widgets/edit_text.dart';

class ConfermaOrdine extends StatefulWidget {
  final double totale;

  const ConfermaOrdine({super.key, required this.totale});

  @override
  State<ConfermaOrdine> createState() => _ConfermaOrdineState();
}

class _ConfermaOrdineState extends State<ConfermaOrdine> {

  TextEditingController indirizzoTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final confermaOrdineViewModel = Provider.of<ConfermaOrdineViewModel>(context, listen: false);
      confermaOrdineViewModel.getIndirizzo();

      final listaSpesaViewModel = Provider.of<ListaSpesaViewModel>(context, listen: false);
      listaSpesaViewModel.getTotale();
    });
  }

  @override
  Widget build(BuildContext context) {
    final confermaOrdineViewModel = Provider.of<ConfermaOrdineViewModel>(context);
    final listaSpesaViewModel = Provider.of<ListaSpesaViewModel>(context);
    indirizzoTextEditController.text = confermaOrdineViewModel.indirizzo;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Riepilogo ordine"),
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Conferma ordine",
                style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "L'ordine sarà spedito all'indirizzo indicato",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300
                ),
              ),
              const SizedBox(height: 8.0),
              EditText(
                textEditingController: indirizzoTextEditController,
                iconData: Icons.location_on,
                hintString: "Indirizzo",
                isPass: false,
                enabled: true,
                type: TextInputType.name,
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Prezzo totale: €",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      "${widget.totale}",
                      style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          if(indirizzoTextEditController.text.isEmpty) {
            confermaOrdineViewModel.showSnackBar("Inserire un indirizzo", context);
          }
          else if(indirizzoTextEditController.text.length > 50){
            confermaOrdineViewModel.showSnackBar("L'indirizzo può contenere max 50 caratteri", context);
          }
          else {
            await listaSpesaViewModel.deleteListaSpesa(); // Attendo il completamento
            listaSpesaViewModel.getListaDellaSpesa(); // Chiamata per riottenere la lista aggiornata
            confermaOrdineViewModel.showSnackBar("Acquisto effettuato con successo", context);
            Navigator.pop(context);
          }
        },
        child: const Icon((Icons.verified)),
      ),
    );
  }
}
