import 'package:flutter/material.dart';
import 'package:green_market_flutter/view/authScreens/password_dimenticata.dart';
import 'package:green_market_flutter/view/authScreens/registrazione.dart';
import 'package:green_market_flutter/main_page.dart';
import 'package:green_market_flutter/viewModel/auth/login_view_model.dart';
import 'package:green_market_flutter/widgets/edit_text.dart';


class MyLoginActivity extends StatefulWidget {
  const MyLoginActivity({super.key});

  @override
  State<MyLoginActivity> createState() => _MyLoginActivityState();
}

class _MyLoginActivityState extends State<MyLoginActivity> {

  LoginViewModel loginViewModel = LoginViewModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
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
                const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Image(
                    image: AssetImage(
                      "images/ic_launcher.png",
                    ),
                  ),
                ),
                const Text(
                  "Accedi",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  "Benvenuto in GreenMarket!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
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
                      EditText(
                        textEditingController: passwordTextEditController,
                        iconData: Icons.lock,
                        hintString: "Password",
                        isPass: true,
                        enabled: true,
                        type: TextInputType.text,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    if(loginViewModel.effettuaLogin(
                        emailTextEditController.text.trim(),
                        passwordTextEditController.text.trim(),
                        context
                    )) {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MainActivity()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white
                  ),
                  child: const Text("Accedi"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c)=> const PasswordDimenticataActivity()));
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black38,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                      child: const Text("Password dimenticata?"),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (c)=> const RegisterActivity()));
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                      child: const Text("Registrati"),
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
