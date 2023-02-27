import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/controller/favourite_controller.dart';
import 'package:store/main.dart';
import 'package:store/model/model.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final CartController cartController = Get.put(CartController());
  final FavouriteController favPutController = Get.put(FavouriteController());
  final FavouriteController favController = Get.find();
  Product? product;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            favController.favCount > 0 ? Colors.grey.shade200 : Colors.white,
        body: favController.favCount > 0
            ? Obx(
                () => ListView.builder(
                    itemCount: favController.favCount,
                    itemBuilder: (contex, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 120,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                                child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Image(
                                    image: NetworkImage(favController
                                        .products.keys
                                        .toList()[index]
                                        .image),
                                    width: 100,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              favController.products.keys
                                                  .toList()[index]
                                                  .title
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              favController.products.keys
                                                      .toList()[index]
                                                      .price
                                                      .toString() +
                                                  '\$',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.black,
                                                    onPrimary:
                                                        Colors.redAccent),
                                                onPressed: () {
                                                  // cartController.addProduct(
                                                  //   widget.product,
                                                  // );
                                                  // favController.removeFavProducts(widget.product);
                                                },
                                                icon: Icon(Icons.shop),
                                                label: Text('Add to Cart')),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            '${favController.products.keys.toList()[index].title} is removed'),
                                        duration: Duration(milliseconds: 1500),
                                        // behavior: SnackBarBehavior.floating,
                                      ));
                                      favController.removeFavProducts(
                                          favController.products.keys
                                              .toList()[index]);
                                      
                                    },
                                    child: Container(
                                        alignment: Alignment.topRight,
                                        child: Icon(Icons.clear)),
                                  )
                                ],
                              ),
                            )),
                          ),
                        ],
                      );
                    }),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image(
                        width: MediaQuery.of(context).size.width,
                        image: NetworkImage(
                            'https://img.freepik.com/premium-photo/engagement-expensive-wedding-retail-buyer-concept-close-up-studio-photo-beautiful-beauty-fashion-affectionate-red-little-heart-full-pushcart-brown-card-isolated-white-background-copy-space_352249-1020.jpg?w=900')),
                  ),
                  Text(
                    'Favorite List is empty',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Looks like you did not \nadd any product yet :(',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
                      },
                      child: Text('Go to Store'))
                ],
              ),
      ),
    );
  }
}
