import 'package:cached_network_image/cached_network_image.dart';
import 'package:confere_estoque/src/layers/domain/entities/product_entity.dart';
import 'package:confere_estoque/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ModalProductsWidget extends StatefulWidget {
  final List<ProductEntity> products;
  const ModalProductsWidget({Key? key, required this.products})
      : super(key: key);

  @override
  State<ModalProductsWidget> createState() => _ModalProductsWidgetState();
}

class _ModalProductsWidgetState extends State<ModalProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              width: 60,
              child: CachedNetworkImage(
                filterQuality: FilterQuality.high,
                imageUrl:
                    'https://cdn-cosmos.bluesoft.com.br/products/${widget.products[index].GTIN}',
                placeholder: (context, url) => SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.colors.primary,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.error, color: Colors.red, size: 30),
                  ],
                ),
              ),
            ),
            contentPadding: EdgeInsets.zero,
            title: Text(widget.products[index].DESCRICAO),
            onTap: () async {},
          );
        },
      ),
    );
  }
}
