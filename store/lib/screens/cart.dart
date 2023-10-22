import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/cart_controller.dart';
import 'package:store/main.dart';
import 'package:store/model/model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

@override
class _CartPageState extends State<CartPage> {
  final CartController cartPutController = Get.put(CartController());
  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            cartController.count > 0 ? Colors.grey.shade200 : Colors.white,
        body: cartController.count > 0
            ? Obx(
                () => Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    cartController.count > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Total Items: ' +
                                    cartController.count.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Text(
                                'Total Price: ' +
                                    cartController.total.toStringAsFixed(2),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              )
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartController.products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: Image(
                                  image: NetworkImage(cartController
                                      .products.keys
                                      .toList()[index]
                                      .image),
                                  height: 50,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      cartController.products.keys
                                          .toList()[index]
                                          .title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      cartController.products.keys
                                              .toList()[index]
                                              .price
                                              .toString() +
                                          '\$',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        cartController.removeProduct(
                                            cartController.products.keys
                                                .toList()[index]);
                                      },
                                      icon: Icon(
                                        Icons.remove_circle,
                                        size: 30,
                                      )),
                                  Text(cartController.products.values
                                      .toList()[index]
                                      .toString()),
                                  IconButton(
                                      onPressed: () {
                                        cartController.addProduct(cartController
                                            .products.keys
                                            .toList()[index]);
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        size: 30,
                                      ))
                                ],
                              ))
                            ],
                          ),
                        );
                      },
                    ),
                    cartController.count > 0
                        ? Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () {},
                                child: Text('Pay ' +
                                    cartController.total.toStringAsFixed(2) +
                                    '\$ only')),
                          )
                        : Container()
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image(
                        width: MediaQuery.of(context).size.width,
                        image: NetworkImage(
                            'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-2506.jpg?size=626&ext=jpg&ga=GA1.2.1892270952.1640863352')),
                  ),
                  Text(
                    'Your Cart is empty',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Looks like you did not \nadd any product yet :(',
                    style: TextStyle(fontSize: 22, color: Colors.black),
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
