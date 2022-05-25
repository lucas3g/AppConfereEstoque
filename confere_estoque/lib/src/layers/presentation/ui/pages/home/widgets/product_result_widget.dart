import 'package:cached_network_image/cached_network_image.dart';
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
    return productEntity.DESCRICAO != 'DESCRICAO'
        ? ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: context.screenWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppTheme.colors.primary,
                    width: 5,
                  ),
                  bottom: BorderSide(
                    color: AppTheme.colors.primary,
                    width: 5,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      width: context.screenWidth * .35,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://cdn-cosmos.bluesoft.com.br/products/${productEntity.GTIN}',
                        placeholder: (context, url) => SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.colors.primary,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
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
                  const SizedBox(height: 5),
                  if (productEntity.DESCRICAO != 'Produto não encontrado' &&
                      productEntity.DESCRICAO != 'DESCRICAO')
                    Row(
                      children: [
                        Text(
                          'Estoque contado hoje: ',
                          style: AppTheme.textStyles.textoSairApp,
                        ),
                        Text(productEntity.EST_CONTADO!.Litros()),
                      ],
                    ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
