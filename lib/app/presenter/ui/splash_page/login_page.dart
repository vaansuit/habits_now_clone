import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_now_app/app/presenter/ui/splash_page/widgets/custom_form_field.dart';
import 'package:habits_now_app/app/presenter/ui/splash_page/widgets/custom_submit_button.dart';
import 'package:habits_now_app/core/constants.dart';
import 'package:http/http.dart' as http;

import '../home/home_page.dart';
import 'register_page.dart';
import 'widgets/animated_logo.dart';
import 'widgets/custom_dialog_box.dart';
import 'widgets/custom_text_button.dart';

// id: sadsamuraidog@gmail.com
// senha: 123456

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final keyForm = GlobalKey<FormState>();
  late AnimationController controller;
  final bool _allowVisibility = false;
  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  // Faz a animação
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
      upperBound: 220,
    );
    // vá no sentido antihorario do duration do 2 ao 0
    controller.forward();
    // Permite que altere o valor ao longo do tempo
    controller.addListener(() {
      setState(() {});
    });
  }

  // Função de login, caso forem usar Dio -> Alterar toda a função
  Future<void> login(String email, String password) async {
    var url = Uri.parse('http://zuplae.vps-kinghost.net:8081/api/acesso/logon');
    Dio dio = Dio();

    var body = jsonEncode({
      'email': email,
      'senha': password,
    });
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    var data;
    if (response.body.isNotEmpty) {
      var data = json.decode(response.body);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Usuário e/ou senha inválido!",
            descriptions:
                "Favor tentar novamente, ou em todo caso registre-se.",
            text: "Ok",
            img: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG-7E4-_iYYhmnRx9p-f3JtDGKvEGwGTeV25Ed4LSoahNyM-xrt5dTlw-uEpV1NccF_6o&usqp=CAU"),
          );
        },
      );
    }

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomePage(
            name: data['nome'],
            image: data['image'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: kBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedLogo(sizeLogo: controller.value),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 30),
                    child: Form(
                      key: keyForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomFormField(
                            controller: emailController,
                            label: 'Email',
                            icon: Icons.mail_outline,
                            hasPassword: false,
                            allowVisibility: true,
                          ),
                          CustomFormField(
                            controller: passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline,
                            hasPassword: true,
                            allowVisibility: false,
                          ),
                          CustomSubmitButton(
                            description: 'Entrar',
                            function: () async {
                              if (keyForm.currentState!.validate()) {
                                login(emailController.text,
                                    passwordController.text);
                              }
                            },
                          ),
                          CustomTextButton(
                            description: 'Não tem uma conta? Cadastre-se!',
                            route: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
