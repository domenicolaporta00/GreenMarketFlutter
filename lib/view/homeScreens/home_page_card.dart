import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:green_market_flutter/viewModel/home/home_page_view_model.dart';
import 'package:green_market_flutter/widgets/edit_text.dart';
import 'package:provider/provider.dart';

class HomePageCard extends StatefulWidget {
  const HomePageCard({super.key});

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {

  TextEditingController emailTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomePageViewModel>(context);

    final ThemeData theme = Theme.of(context);
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "images/ic_launcher.png",
                  height: 60,
                  width: 60,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    "Ciao ${homeViewModel.nome} \u{1F44B}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
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
