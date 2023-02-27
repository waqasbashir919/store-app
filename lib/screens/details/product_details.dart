import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/controller/favourite_controller.dart';
import 'package:store/main.dart';
import 'package:store/model/model.dart';
import 'package:store/screens/favourites.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.index, required this.product})
      : super(key: key);
  final int index;
  final product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final CartController cartController = Get.put(CartController());
  final FavouriteController favController = Get.put(FavouriteController());

  double? oldPrice;
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    oldPrice = 89.0;
    oldPrice = (widget.product.price * 0.1.toInt()) + widget.product.price;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
          title: Icon(
            Icons.shop,
            color: Colors.black,
            size: 30,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image(
                        image: NetworkImage(widget.product.image),
                        height: 250,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isAdded = !isAdded;
                        });

                        favController.addFavProduct(widget.product);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Favorite page updated'),
                          duration: Duration(milliseconds: 1500),
                          // behavior: SnackBarBehavior.floating,
                        ));

                        // if (cartController.products.keys
                        //     .toList()[widget.index]) {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content:
                        //         Text('This product already exist in the cart'),
                        //     duration: Duration(milliseconds: 1500),
                        //     // behavior: SnackBarBehavior.floating,
                        //   ));
                        // } else {
                        //   favController.addFavProduct(
                        //     widget.product,
                        //   );
                        // }

                        // if (cartController.products.isNotEmpty) {
                        //   var a = cartController.products[0];
                        //   if (a == widget.product) {
                        //     log(a.toString());
                        //   } else {
                        //     log('no');
                        //   }

                        //   var isProduct = false;

                        //     cartController.products.values.map((product) {
                        //   log(product.toString());
                        //   if (product == widget.product) {
                        //     return true;
                        //   } else {
                        //     return false;
                        //   }
                        // }).toList();
                        //   isProduct == true
                        //       ? ScaffoldMessenger.of(context)
                        //           .showSnackBar(SnackBar(
                        //           content:
                        //               Text('Product already exist in the cart'),
                        //           duration: Duration(milliseconds: 1500),
                        //           // behavior: SnackBarBehavior.floating,
                        //         ))
                        //       : favController.addFavProduct(
                        //           widget.product,
                        //         );
                        // }
                      },
                      child: Container(
                          height: 240,
                          width: 20,
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            isAdded == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 30,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.product.title.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Old Price: ' + oldPrice!.toStringAsFixed(2) + '\$',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'New Price: ' + widget.product.price.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.product.category.toString(),
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(widget.product.rating.rate.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: RatingBar.builder(
                            initialRating: double.parse(
                                widget.product.rating.rate.toString()),
                            minRating: 0,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 25,
                            ignoreGestures: true,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Total reviews : ' +
                          widget.product.rating.count.toString(),
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Description\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  widget.product.description.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black, onPrimary: Colors.redAccent),
                      onPressed: () {
                        cartController.addProduct(
                          widget.product,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('You have added new product to the cart'),
                          duration: Duration(milliseconds: 1500),
                          // behavior: SnackBarBehavior.floating,
                        ));
                      },
                      icon: Icon(Icons.shop),
                      label: Text('Add to Cart')),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
