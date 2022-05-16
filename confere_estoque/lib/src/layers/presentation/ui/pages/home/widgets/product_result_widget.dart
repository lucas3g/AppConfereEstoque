import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductResultWidget extends StatelessWidget {
  const ProductResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: AppTheme.colors.primary.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Coca-Cola',
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyles.titleMercadoria,
                ),
              ),
            ],
          ),
          const Text('Custo Real: R\$ 6,00'),
          const Text('Valor Venda: R\$ 10,00'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Estoque',
                style: AppTheme.textStyles.titleEstoque,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Estoque Contabil: 6,00'),
          const Text('Estoque Fisico: 6,00'),
        ],
      ),
    );
  }
}
