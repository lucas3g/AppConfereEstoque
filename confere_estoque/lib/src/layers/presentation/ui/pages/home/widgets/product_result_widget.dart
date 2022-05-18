import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:confere_estoque/src/utils/constants.dart';
import 'package:confere_estoque/src/utils/formatters.dart';
import 'package:flutter/material.dart';

class ProductResultWidget extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductResultWidget({Key? key, required this.productEntity})
      : super(key: key);

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
                  productEntity.DESCRICAO,
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyles.titleMercadoria,
                ),
              ),
            ],
          ),
          if (productEntity.DESCRICAO != 'Produto não encontrado') ...[
            Text('Custo Real: ${productEntity.CUSTO_ULTIMO.reais()}'),
            Text('Valor Venda: ${productEntity.VENDA.reais()}'),
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
            Text('Estoque Contabil: ${productEntity.EST_ATUAL!.Litros()}'),
            Text('Estoque Fisico:${productEntity.EST_FISICO!.Litros()}'),
          ]
        ],
      ),
    );
  }
}
