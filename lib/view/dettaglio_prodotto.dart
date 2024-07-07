import 'package:flutter/material.dart';
import 'package:green_market_flutter/model/prodotto.dart';

class DettaglioProdotto extends StatefulWidget {
  final Prodotto prodotto;

  const DettaglioProdotto({super.key, required this.prodotto});

  @override
  State<DettaglioProdotto> createState() => _DettaglioProdottoState();
}

class _DettaglioProdottoState extends State<DettaglioProdotto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("GreenMarket"),
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(0.0),
                child: Image(
                  image: AssetImage(
                    "images/ic_launcher.png",
                  ),
                ),
              ),
              Text(
                widget.prodotto.nome,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "1kg",
                style: TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
              const SizedBox(height: 16.0),
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
                      onPressed: (){},
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    '1',
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
                      onPressed: (){},
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "€${widget.prodotto.prezzo}",
                    style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
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
        onPressed: (){},
        child: const Icon((Icons.add_shopping_cart)),
      ),
    );
  }
}
