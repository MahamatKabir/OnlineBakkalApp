import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:gracery/consts/firebase_consts.dart';
import 'package:gracery/inner_screens/product_details.dart';
import 'package:gracery/models/product_model.dart';
import 'package:gracery/providers/cart_provider.dart';
import 'package:gracery/providers/wishlist_provider.dart';
import 'package:gracery/services/global_methods.dart';
import 'package:gracery/services/utils.dart';
import 'package:gracery/widget/heart_btn.dart';
import 'package:gracery/widget/text_widget.dart';
import 'package:provider/provider.dart';
import 'price_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    //final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 2.0, left: 3.0, right: 3.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            // viewedProdProvider.addProductToHistory(productId: productModel.id);
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            //GlobalMethods.navigateTo(
            // ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FancyShimmerImage(
                          imageUrl: productModel.imageUrl,
                          height: size.width * 0.22,
                          width: size.width * 0.22,
                          boxFit: BoxFit.fill,
                        ),
                        Column(
                          children: [
                            TextWidget(
                              text: productModel.isPiece ? '1Piece' : '1KG',
                              color: color,
                              textSize: 22,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: isInCart
                                      ? null
                                      : () async {
                                          final User? user =
                                              authInstance.currentUser;
                                          if (user == null) {
                                            GlobalMethods.errorDialog(
                                                subtitle:
                                                    'No user found , Pleae login first',
                                                context: context);
                                            return;
                                          }
                                          await GlobalMethods.addToCart(
                                              productId: productModel.id,
                                              quantity: 1,
                                              context: context);
                                          await cartProvider.fetchCart();
                                        },
                                  child: Icon(
                                    isInCart
                                        ? IconlyBold.bag2
                                        : IconlyLight.bag2,
                                    size: 22,
                                    color: isInCart ? Colors.green : color,
                                  ),
                                ),
                                HeartBTN(
                                  productId: productModel.id,
                                  isInWishlist: isInWishlist,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    PriceWidget(
                      salePrice: productModel.salePrice,
                      price: productModel.price,
                      textPrice: '1',
                      isOnSale: true,
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Container(
                        height: 30,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromARGB(255, 159, 66, 66),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3.0,
                                blurRadius: 4.0)
                          ],
                        ),
                        child: Center(
                          child: TextWidget(
                            text: productModel.title,
                            color: color,
                            textSize: 16,
                            isTitle: true,
                          ),
                        ),
                      ),
                    ),
                    //const SizedBox(height: 5),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
