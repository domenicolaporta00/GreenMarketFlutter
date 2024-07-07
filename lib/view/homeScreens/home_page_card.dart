import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_market_flutter/viewModel/home/home_page_view_model.dart';
import 'package:provider/provider.dart';

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
            )

            /*EditText(
              textEditingController: emailTextEditController,
              iconData: Icons.email,
              hintString: "Email",
              isPass: false,
              enabled: true,
              type: TextInputType.emailAddress,
            ),
            ElevatedButton(
              onPressed: (){
                homeViewModel.setNome(emailTextEditController.text.trim());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white
              ),
              child: const Text("Accedi"),
            ),*/
          ],
        ),
      ),
    );
  }
}
