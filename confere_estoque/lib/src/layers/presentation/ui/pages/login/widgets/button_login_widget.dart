// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/events/login_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/states/login_states.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/home_page.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';

class ButtonLoginWidget extends StatefulWidget {
  final GlobalKey<FormState> keyCNPJ;
  final GlobalKey<FormState> keyLogin;
  final GlobalKey<FormState> keyPassword;
  final String cnpj;
  final String login;
  final String password;
  const ButtonLoginWidget({
    Key? key,
    required this.keyCNPJ,
    required this.keyLogin,
    required this.keyPassword,
    required this.cnpj,
    required this.login,
    required this.password,
  }) : super(key: key);

  @override
  State<ButtonLoginWidget> createState() => _ButtonLoginWidgetState();
}

class _ButtonLoginWidgetState extends State<ButtonLoginWidget> {
  final bloc = GetIt.I.get<LoginBloc>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    sub = bloc.stream.listen((state) async {
      if (state is LoginSuccessState) {
        await Future.delayed(const Duration(seconds: 1));
        await Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const HomePage(),
            type: PageTransitionType.rightToLeftWithFade,
            duration: const Duration(milliseconds: 500),
            reverseDuration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
          ),
          (route) => false,
        );
      } else if (state is LoginErrorState) {
        const snackBar = SnackBar(
          content: Text('Opss... Não foi possivel fazer o login.'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!widget.keyCNPJ.currentState!.validate() ||
            !widget.keyLogin.currentState!.validate() ||
            !widget.keyPassword.currentState!.validate()) {
          return;
        }
        FocusScope.of(context).requestFocus(FocusNode());
        bloc.add(LoginSignInEvent(
          cnpj: widget.cnpj,
          login: widget.login,
          password: widget.password,
        ));
      },
      child: BlocBuilder<LoginBloc, LoginStates>(
          bloc: bloc,
          builder: (context, state) {
            return AnimatedContainer(
              alignment: Alignment.center,
              height: 45,
              width: state is LoginLoadingState || state is LoginSuccessState
                  ? 45
                  : context.screenWidth,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  color: state is LoginSuccessState
                      ? AppTheme.colors.logadoComSucesso
                      : AppTheme.colors.primary,
                  borderRadius: BorderRadius.circular(
                      state is LoginLoadingState || state is LoginSuccessState
                          ? 50
                          : 10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: state is LoginSuccessState
                          ? AppTheme.colors.logadoComSucesso
                          : AppTheme.colors.primary,
                      offset: const Offset(0, 5),
                    )
                  ]),
              child: Stack(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity:
                        state is LoginLoadingState || state is LoginSuccessState
                            ? 0
                            : 1,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          'Entrar',
                          style:
                              AppTheme.textStyles.button.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity:
                        state is LoginLoadingState || state is LoginSuccessState
                            ? 1
                            : 0,
                    child: Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: state is LoginSuccessState
                            ? const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 25,
                              )
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
