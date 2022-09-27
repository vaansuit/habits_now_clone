import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:habits_now_app/app/presenter/ui/splash_page/login_page.dart';
import 'package:habits_now_app/app/presenter/ui/splash_page/widgets/animated_logo.dart';
import 'package:habits_now_app/app/presenter/ui/splash_page/widgets/custom_form_field.dart';
import 'package:habits_now_app/app/presenter/ui/splash_page/widgets/custom_submit_button.dart';
import 'package:habits_now_app/app/presenter/ui/splash_page/widgets/custom_text_button.dart';
import 'package:http/http.dart' as http;

import 'widgets/custom_dialog_box.dart';
import 'widgets/data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late DataModel _dataModel;
  // Ajuda a controlar nosso formulário (Form)
  final keyForm = GlobalKey<FormState>();

// Controlador dos inputs
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

// Função para subir dados
  Future<DataModel> submitData(
      String email, String name, String image, String password) async {
    var url = Uri.parse('http://zuplae.vps-kinghost.net:8081/api/user');
    var body = jsonEncode(
      {
        "email": email,
        "nome": name,
        "image": image,
        "senha": password,
      },
    );
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else if (response.statusCode == 409) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Usuário já cadastrado no sistema!",
            descriptions: "Favor cadastrar-se com outro e-mail",
            text: "Ok",
            img: Image.network(
                "https://www.askideas.com/media/76/Funny-Meme-Faces-17.jpg"),
          );
        },
      );
    }
    throw Exception('');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFF161616),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedLogo(sizeLogo: 165.5),
                Form(
                  key: keyForm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 50),
                    child: Column(
                      children: [
                        CustomFormField(
                          controller: emailController,
                          label: "E-mail",
                          icon: Icons.email_outlined,
                          allowVisibility: true,
                          hasPassword: false,
                        ),
                        CustomFormField(
                          controller: passwordController,
                          label: "Password",
                          icon: Icons.lock_outline,
                          hasPassword: true,
                          allowVisibility: false,
                        ),
                        CustomFormField(
                          controller: nameController,
                          label: "Name",
                          icon: Icons.person_outline,
                          allowVisibility: true,
                          hasPassword: false,
                        ),
                        CustomFormField(
                          controller: imageController,
                          label: "Picture",
                          icon: Icons.image_outlined,
                          allowVisibility: true,
                          hasPassword: false,
                        ),
                        CustomSubmitButton(
                          description: "Cadastrar",
                          function: () async {
                            String email = emailController.text;
                            String name = nameController.text;
                            String image = imageController.text;
                            String password = passwordController.text;
                            DataModel data = await submitData(
                              email,
                              name,
                              image,
                              password,
                            );
                            if (keyForm.currentState!.validate()) {
                              setState(() {
                                _dataModel = data;
                              });
                            }
                          },
                        ),
                        CustomTextButton(
                          description: "Já tem uma conta? Faça login",
                          route: () {
                            Navigator.of(context).pop();
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
    );
  }
}
