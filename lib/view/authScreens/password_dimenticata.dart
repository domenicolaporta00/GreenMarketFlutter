import 'package:flutter/material.dart';
import 'package:green_market_flutter/viewModel/auth/password_dimenticata_view_model.dart';

import '../../widgets/edit_text.dart';
import 'login.dart';

class PasswordDimenticataActivity extends StatefulWidget {
  const PasswordDimenticataActivity({super.key});

  @override
  State<PasswordDimenticataActivity> createState() => _PasswordDimenticataActivityState();
}

class _PasswordDimenticataActivityState extends State<PasswordDimenticataActivity> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditController = TextEditingController();
  PasswordDimenticataViewModel passwordDimenticataViewModel = PasswordDimenticataViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (c)=> const MyLoginActivity()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("GreenMarket"),
          automaticallyImplyLeading: false,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Inserisci l'indirizzo email associato al tuo account",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EditText(
                        textEditingController: emailTextEditController,
                        iconData: Icons.email,
                        hintString: "Email",
                        isPass: false,
                        enabled: true,
                        type: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      if(passwordDimenticataViewModel.recuperaPassword(
                        emailTextEditController.text.trim(),
                        context
                      )) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c)=> const MyLoginActivity()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white
                    ),
                    child: const Text('Recupera password')
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (c)=> const MyLoginActivity()));
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black38,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      )
                  ),
                  child: const Text("Torna al Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
