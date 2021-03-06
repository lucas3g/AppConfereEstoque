import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/events/login_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/config/config_page.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/login/widgets/button_login_widget.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/login/widgets/my_input_widget.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:confere_estoque/src/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cnpjController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final scrollController = ScrollController();
  late bool visiblePassword = false;
  FocusNode cnpj = FocusNode();
  FocusNode login = FocusNode();
  FocusNode password = FocusNode();
  GlobalKey<FormState> keyPassword = GlobalKey<FormState>();
  GlobalKey<FormState> keyLogin = GlobalKey<FormState>();
  GlobalKey<FormState> keyCNPJ = GlobalKey<FormState>();

  late String fcnpj = '';
  late String fuser = '';
  late String fsenha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'ConferĂȘncia de Estoque',
          style: AppTheme.textStyles.titleAppBar,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                PageTransition(
                  child: const ConfigPage(),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: const Duration(milliseconds: 500),
                  reverseDuration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  alignment: Alignment.center,
                ),
              );
            },
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .04),
        child: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: Platform.isAndroid
                ? context.screenHeight * 0.89
                : context.screenHeight * 0.88,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  children: [
                    MyInputWidget(
                      onTap: () {
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      formKey: keyCNPJ,
                      textEditingController: cnpjController,
                      focusNode: cnpj,
                      label: 'CNPJ',
                      hintText: 'Digite o CNPJ da Empresa',
                      campoVazio: 'CNPJ da empresa nĂŁo pode ser em branco.',
                      onFieldSubmitted: (value) {
                        login.requestFocus();
                        cnpjController.text = value!.trim();
                      },
                      onChanged: (String? cnpj) {
                        fcnpj = cnpj!;
                      },
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CnpjInputFormatter(),
                      ],
                    ),
                    SizedBox(height: context.screenWidth * .03),
                    MyInputWidget(
                      onTap: () {
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      formKey: keyLogin,
                      textEditingController: loginController,
                      focusNode: login,
                      hintText: 'Digite seu usuĂĄrio',
                      label: 'UsuĂĄrio',
                      campoVazio: 'UsuĂĄrio nĂŁo pode ser em branco.',
                      onFieldSubmitted: (value) {
                        password.requestFocus();
                        loginController.text = value!.trim();
                      },
                      onChanged: (String? user) {
                        fuser = user!;
                      },
                      inputFormaters: [UpperCaseTextFormatter()],
                    ),
                    SizedBox(height: context.screenWidth * .03),
                    MyInputWidget(
                      onTap: () {
                        scrollController.animateTo(
                          50,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      textCapitalization: TextCapitalization.none,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      formKey: keyPassword,
                      textEditingController: passwordController,
                      focusNode: password,
                      obscureText: !visiblePassword,
                      label: 'Senha',
                      hintText: 'Digite sua Senha',
                      campoVazio: 'Senha nĂŁo pode ser em branco',
                      suffixIcon: GestureDetector(
                        child: Icon(
                          visiblePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 25,
                          color: visiblePassword
                              ? AppTheme.colors.primary
                              : const Color(0xFF666666),
                        ),
                        onTap: () {
                          visiblePassword = !visiblePassword;
                          setState(() {});
                        },
                      ),
                      onFieldSubmitted: (value) async {
                        if (!keyCNPJ.currentState!.validate() ||
                            !keyLogin.currentState!.validate() ||
                            !keyPassword.currentState!.validate()) {
                          return;
                        }
                        passwordController.text = value!.trim();
                        FocusScope.of(context).requestFocus(FocusNode());
                        GetIt.I.get<LoginBloc>().add(LoginSignInEvent(
                              cnpj: cnpjController.text.trim(),
                              login: loginController.text.trim(),
                              password: passwordController.text.trim(),
                            ));
                      },
                      onChanged: (String? password) {
                        fsenha = password!;
                        setState(() {});
                      },
                      inputFormaters: [UpperCaseTextFormatter()],
                    ),
                    SizedBox(height: context.screenWidth * .03),
                    ButtonLoginWidget(
                      keyCNPJ: keyCNPJ,
                      keyLogin: keyLogin,
                      keyPassword: keyPassword,
                      cnpj: fcnpj.trim(),
                      login: fuser.trim(),
                      password: fsenha.trim(),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  'EL Sistemas - 2022 - 54 3364 1588',
                  style: AppTheme.textStyles.textoSairApp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
