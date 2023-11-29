import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gracery/services/global_methods.dart';
import 'package:gracery/widget/back_widget.dart';
import 'package:gracery/widget/text_widget.dart';
import '../../services/utils.dart';
import 'wishlist_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackWidget(),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: TextWidget(
              text: 'Wishlist (2)',
              color: color,
              isTitle: true,
              textSize: 22,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                      title: 'Empty your cart?',
                      subtitle: 'Are you sure?',
                      fct: () {},
                      context: context);
                },
                icon: Icon(
                  IconlyBroken.delete,
                  color: color,
                ),
              ),
            ]),
        body: MasonryGridView.count(
          crossAxisCount: 2,
          // mainAxisSpacing: 16,
          // crossAxisSpacing: 20,
          itemBuilder: (context, index) {
            return const WishlistWidget();
          },
        ));
  }
}
