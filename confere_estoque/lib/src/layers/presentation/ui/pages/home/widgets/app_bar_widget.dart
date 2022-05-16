import 'package:confere_estoque/src/layers/presentation/ui/pages/home/widgets/drop_down_widget.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final BuildContext context;

  const AppBarWidget({Key? key, required this.context}) : super(key: key);

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
                      onPressed: () async {},
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
