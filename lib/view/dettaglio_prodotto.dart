import 'package:flutter/material.dart';
import 'package:green_market_flutter/model/product_model.dart';
import 'package:green_market_flutter/viewModel/dettaglio_prodotto_view_model.dart';
import 'package:provider/provider.dart';

class DettaglioProdotto extends StatefulWidget {
  final ProductModel prodotto;

  const DettaglioProdotto({super.key, required this.prodotto});

  @override
  State<DettaglioProdotto> createState() => _DettaglioProdottoState();
}

class _DettaglioProdottoState extends State<DettaglioProdotto> {
  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dettaglioProdottoViewModel = Provider.of<DettaglioProdottoViewModel>(context, listen: false);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final dettaglioProdottoViewModel = Provider.of<DettaglioProdottoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Dettaglio prodotto"),
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                      image: DecorationImage(
                          image: AssetImage(
                            widget.prodotto.foto,
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.prodotto.nome,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w500
                ),
              ),
              const Text(
                "1kg",
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      color: Colors.white,
                      onPressed: (){
                        dettaglioProdottoViewModel.decrementaQuantita(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    "${dettaglioProdottoViewModel.quantita}",
                    style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: (){
                        dettaglioProdottoViewModel.incrementaQuantita(context);
                      },
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "€${widget.prodotto.prezzo}",
                    style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                "Descrizione",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w300, color: Colors.black87),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              Text(
                widget.prodotto.descrizione,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          dettaglioProdottoViewModel.addProdottoInLista(widget.prodotto, context);
          Navigator.pop(context);
        },
        child: const Icon((Icons.add_shopping_cart)),
      ),
    );
  }
}
