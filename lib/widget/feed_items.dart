import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gracery/consts/firebase_consts.dart';
import 'package:gracery/inner_screens/product_details.dart';
import 'package:gracery/models/product_model.dart';
import 'package:gracery/providers/cart_provider.dart';
import 'package:gracery/providers/wishlist_provider.dart';
import 'package:gracery/services/global_methods.dart';
import 'package:gracery/widget/price_widget.dart';
import 'package:gracery/widget/text_widget.dart';
import 'package:provider/provider.dart';
import '../services/utils.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    //final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 2.0, left: 5.0, right: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            // viewedProdProvider.addProductToHistory(productId: productModel.id);
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            //GlobalMethods.navigateTo(
            // ctx: context, routeName: ProductDetails.routeName);
          },
          borderRadius: BorderRadius.circular(12),
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
            child: Column(children: [
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.width * 0.34,
                width: size.width * 0.3,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextWidget(
                        text: productModel.title,
                        maxLines: 1,
                        color: color,
                        textSize: 20,
                        isTitle: true,
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: HeartBTN(
                          productId: productModel.id,
                          isInWishlist: isInWishlist,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: PriceWidget(
                        salePrice: productModel.salePrice,
                        price: productModel.price,
                        textPrice: _quantityTextController.text,
                        isOnSale: productModel.isOnSale,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: FittedBox(
                              child: TextWidget(
                                text: productModel.isPiece ? 'Piece' : 'KG',
                                color: color,
                                textSize: 20,
                                isTitle: true,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: TextFormField(
                            controller: _quantityTextController,
                            key: const ValueKey('10 \$'),
                            style: TextStyle(color: color, fontSize: 18),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.,]')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _quantityTextController.text = '1';
                                } else {
                                  // total = usedPrice *
                                  //     int.parse(_quantityTextController.text);
                                }
                              });
                            },
                            onSaved: (value) {},
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Color.fromARGB(255, 159, 66, 66)),
                child: SizedBox(
                  //width: double.infinity,

                  child: TextButton(
                    onPressed: isInCart
                        ? null
                        : () async {
                            //if (isInCart) {
                            //return;
                            //}
                            final User? user = authInstance.currentUser;
                            if (user == null) {
                              GlobalMethods.errorDialog(
                                  subtitle: 'No user found , Pleae login first',
                                  context: context);
                              return;
                            }
                            await GlobalMethods.addToCart(
                                productId: productModel.id,
                                quantity:
                                    int.parse(_quantityTextController.text),
                                context: context);
                            await cartProvider.fetchCart();
                            // cartProvider.addProductsToCart(
                            //     productId: productModel.id,
                            //     quantity: int.parse(_quantityTextController.text));
                          },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).cardColor),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(40.0),
                                topLeft: Radius.circular(90),
                                topRight: Radius.circular(10)),
                          ),
                        )),
                    child: TextWidget(
                      text: isInCart ? 'in Cart' : 'Add to cart',
                      maxLines: 1,
                      color: Color.fromARGB(255, 159, 66, 66),
                      textSize: 20,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
