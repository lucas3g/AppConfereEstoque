// ignore_for_file: use_build_context_synchronously

import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/events/login_events.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:confere_estoque/src/layers/presentation/blocs/login_bloc/states/login_states.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/drop_down_widget.dart';
import 'package:confere_estoque/src/layers/presentation/ui/pages/login/login_page.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final BuildContext context;

  AppBarWidget({Key? key, required this.context}) : super(key: key);

  final bloc = GetIt.I.get<LoginBloc>();

  void confirmarSair() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(bottom: 15, top: 20, right: 20, left: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/sair.svg',
                height: 130,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Deseja realmente sair da aplicação?',
                style: AppTheme.textStyles.textoSairApp,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 45,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Não',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () async {
                      bloc.add(LoginLogOutEvent());
                      bloc.stream.listen((state) {
                        if (state is LoginLogOutSuccessState) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                child: const LoginPage(),
                                type: PageTransitionType.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 500),
                                reverseDuration:
                                    const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                alignment: Alignment.center,
                              ),
                              (route) => false);
                        }
                      });
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 8,
                      shadowColor: AppTheme.colors.primary,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 45,
                        width: 120,
                        decoration: BoxDecoration(
                          color: AppTheme.colors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                            child: Text(
                          'Sim',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Widget get child => Stack(
        children: [
          Container(
            height: context.screenHeight * 0.13,
            decoration: BoxDecoration(
              color: AppTheme.colors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.screenHeight * 0.04),
                child: Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.05,
                    ),
                    Text(
                      'Conferência de Estoque',
                      style: AppTheme.textStyles.titleAppBar,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onPressed: confirmarSair,
                    )
                  ],
                ),
              ),
              const DropDownWidget(),
            ],
          ),
        ],
      );

  @override
  Size get preferredSize => Size.fromHeight(context.screenHeight * 0.14);
}
