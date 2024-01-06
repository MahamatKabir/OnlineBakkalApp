import 'package:flutter/material.dart';
import 'package:gracery/models/product_model.dart';
import 'package:gracery/providers/product_provider.dart';
import 'package:gracery/widget/back_widget.dart';
import 'package:gracery/widget/empty_products_widget.dart';
import 'package:gracery/widget/on_sale_widget.dart';
import 'package:gracery/widget/text_widget.dart';
import 'package:provider/provider.dart';
import '../services/utils.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productsProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productsProviders.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body: productsOnSale.isEmpty
          ? const EmptyProdWidget(text: 'No products belong to this category')
          : GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              // crossAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.60),
              children: List.generate(productsOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productsOnSale[index], child: const OnSaleWidget());
              }),
            ),
    );
  }
}
