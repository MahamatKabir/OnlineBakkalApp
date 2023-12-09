import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:gracery/consts/firebase_consts.dart';
import 'package:gracery/providers/wishlist_provider.dart';
import 'package:gracery/services/global_methods.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool isInWishlist;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return GestureDetector(
      onTap: () {
        final User? user = authInstance.currentUser;
        if (user == null) {
          GlobalMethods.errorDialog(
              subtitle: 'No user found , Pleae login first', context: context);
          return;
        }
        wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist == true ? IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color: isInWishlist == true ? Colors.red : color,
      ),
    );
  }
}
