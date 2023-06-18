import 'package:chatndong/controllers/auth_controller.dart';
import 'package:chatndong/screens/Home_screen.dart';
import 'package:chatndong/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthController authController = Get.put(AuthController());
  final formKey= GlobalKey<FormState>();
  String email= "";
  String password= "";
  bool showPassword= false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 100,
                child: ClipOval(
                  child: Image.network(
                    'https://picsum.photos/200',
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              const Text(
                "Connectez vous pour pouvoir discuter avec vos amis",
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        child:  TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            fillColor: Colors.white,
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          style: TextStyle(color: Colors.white),
                          onChanged: (val){
                           setState(() {
                             email = val;
                           });
                          },
                          validator: (val){
                            if(val!.isEmpty){
                              return "Veillez saisir votre email";
                            }
                            return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(email) ? null : "Email est invalid";
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 70,
                        child:  TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              fillColor: Colors.white,
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(Icons.lock_clock_outlined),
                              suffixIcon: Icon(Icons.remove_red_eye)),
                          style: TextStyle(color: Colors.white),
                          onChanged: (val)=>setState(() {
                            password=val;
                          }),
                          obscureText: true,
                          validator: (val){
                            if(val!.isEmpty){
                              return "Veillez saissir votre mot de passe ";
                            }else if(val.length < 8){
                              return "Mot de passe est trop court";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              authController.loginUser(email, password);
                            }
                          },
                          child: Text('Se connecter'),
                          style: ElevatedButton.styleFrom(
                            textStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                            backgroundColor: Color(0xFFECDEA7),
                          ),
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            const Text.rich(
                              TextSpan(
                                text: "Vous n'avez pas de compte",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Register()));
                              },
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(color: Colors.white),
                              ),
                              child: const Text.rich(
                                TextSpan(text: "Créer un compte"),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
      ),
    ));
  }
}
