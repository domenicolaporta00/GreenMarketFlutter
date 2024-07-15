import 'package:flutter/material.dart';
import 'package:green_market_flutter/viewModel/auth/registrazione_view_model.dart';

import '../../widgets/edit_text.dart';
import 'login.dart';

class RegisterActivity extends StatefulWidget {
  const RegisterActivity({super.key});

  @override
  State<RegisterActivity> createState() => _RegisterActivityState();
}

class _RegisterActivityState extends State<RegisterActivity> {

  RegistrazioneViewModel registrazioneViewModel = RegistrazioneViewModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nomeTextEditController = TextEditingController();
  TextEditingController cognomeTextEditController = TextEditingController();
  TextEditingController indirizzoTextEditController = TextEditingController();
  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController passwordConfirmTextEditController = TextEditingController();
  bool isChecked = false;

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
                  "Registrati",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      EditText(
                        textEditingController: nomeTextEditController,
                        iconData: Icons.person,
                        hintString: "Nome",
                        isPass: false,
                        enabled: true,
                        type: TextInputType.text,
                      ),
                      EditText(
                        textEditingController: cognomeTextEditController,
                        iconData: Icons.person,
                        hintString: "Cognome",
                        isPass: false,
                        enabled: true,
                        type: TextInputType.text,
                      ),
                      EditText(
                        textEditingController: indirizzoTextEditController,
                        iconData: Icons.location_on,
                        hintString: "Indirizzo",
                        isPass: false,
                        enabled: true,
                        type: TextInputType.text,
                      ),
                      EditText(
                        textEditingController: emailTextEditController,
                        iconData: Icons.email,
                        hintString: "Email",
                        isPass: false,
                        enabled: true,
                        type: TextInputType.emailAddress,
                      ),
                      EditText(
                        textEditingController: passwordTextEditController,
                        iconData: Icons.lock,
                        hintString: "Password",
                        isPass: true,
                        enabled: true,
                        type: TextInputType.text,
                      ),
                      EditText(
                        textEditingController: passwordConfirmTextEditController,
                        iconData: Icons.lock,
                        hintString: "Conferma password",
                        isPass: true,
                        enabled: true,
                        type: TextInputType.text,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: (){
                        //TODO
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black38,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                      child: const Text(
                        "Ho letto e accetto i termini e condizioni d'uso",
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      if(isChecked) {
                        if(await registrazioneViewModel.effettuaRegistrazione(
                            nomeTextEditController.text.trim(),
                            cognomeTextEditController.text.trim(),
                            indirizzoTextEditController.text.trim(),
                            emailTextEditController.text.trim(),
                            passwordTextEditController.text.trim(),
                            passwordConfirmTextEditController.text.trim(),
                            {},
                            context
                        )) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (c)=> const MyLoginActivity()));
                        }
                      }
                      else {
                        registrazioneViewModel.showSnackBar("Accetta i termini e condizioni d'uso",
                            context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white
                    ),
                    child: const Text('Continua')
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hai già un account?",
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
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
                      child: const Text("Accedi"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
