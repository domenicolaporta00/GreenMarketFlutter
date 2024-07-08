import 'package:flutter/material.dart';
import 'package:green_market_flutter/viewModel/home/home_page_view_model.dart';
import 'package:green_market_flutter/viewModel/home/profilo_view_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/edit_text.dart';

class ProfiloCard extends StatefulWidget {
  const ProfiloCard({super.key});

  @override
  State<ProfiloCard> createState() => _ProfiloCardState();
}

class _ProfiloCardState extends State<ProfiloCard> {

  TextEditingController nomeTextEditController = TextEditingController();
  TextEditingController cognomeTextEditController = TextEditingController();
  TextEditingController indirizzoTextEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profiloViewModel = Provider.of<ProfiloViewModel>(context, listen: false);
      Provider.of<HomePageViewModel>(context, listen: false);
      profiloViewModel.getDati();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profiloViewModel = Provider.of<ProfiloViewModel>(context);
    final homeViewModel = Provider.of<HomePageViewModel>(context);
    nomeTextEditController.text = profiloViewModel.nome;
    cognomeTextEditController.text = profiloViewModel.cognome;
    indirizzoTextEditController.text = profiloViewModel.indirizzo;

    return SingleChildScrollView(
      child: Card(
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100.0),
                    image: const DecorationImage(
                        image: AssetImage(
                          "images/profilo.jpg",
                        ),
                        fit: BoxFit.cover
                    )
                ),
              ),
              EditText(
                textEditingController: nomeTextEditController,
                iconData: Icons.person,
                hintString: "Nome",
                isPass: false,
                enabled: true,
                type: TextInputType.name,
              ),
              EditText(
                textEditingController: cognomeTextEditController,
                iconData: Icons.person,
                hintString: "Cognome",
                isPass: false,
                enabled: true,
                type: TextInputType.name,
              ),
              EditText(
                textEditingController: indirizzoTextEditController,
                iconData: Icons.email,
                hintString: "Indirizzo",
                isPass: false,
                enabled: true,
                type: TextInputType.name,
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      homeViewModel.setNome(nomeTextEditController.text.trim());
                      profiloViewModel.setDati(
                          nomeTextEditController.text.trim(),
                          cognomeTextEditController.text.trim(),
                          indirizzoTextEditController.text.trim(),
                          context
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white
                    ),
                    child: const Text("Salva"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      profiloViewModel.getDati();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white
                    ),
                    child: const Text("Annulla"),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: (){
                    profiloViewModel.logout(context);
                  },
                  child: const Text(
                    "Esci dall'account",
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: (){
                    profiloViewModel.deleteAccount(context);
                  },
                  child: const Text(
                    "Elimina account utente",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
