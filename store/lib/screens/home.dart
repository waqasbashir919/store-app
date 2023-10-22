import 'package:flutter/material.dart';
import 'package:store/animation/screen_animation.dart';
import 'package:store/screens/details/product_details.dart';
import 'package:store/services/remote_services.dart';
import 'package:store/model/model.dart';

import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.isSearch}) : super(key: key);
  final bool isSearch;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product>? products;
  List? display_list;

  final scrollController = ScrollController();
  int limit = 10;
  int page = 1;

  @override
  void initState() {
    super.initState();

    fetchProducts();
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent ==
            scrollController.offset) {
          fetchProducts();
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bool isLoaded = false;
  bool hasMore = true;

  final searchText = TextEditingController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: ListView(
            controller: scrollController,
            children: [
              widget.isSearch == true
                  ? Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: searchText,
                        onChanged: (value) => searchProduct(value),
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            suffixIcon: searchText.text.length > 0
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        searchText.text = '';
                                      });
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                    ),
                                  )
                                : null,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search items',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none)),
                      ))
                  : SizedBox(),
              isLoaded == true
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: display_list!.length > 0
                          ? GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: display_list!.length + 1,
                              itemBuilder: (context, index) {
                                if (index < display_list!.length) {
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        final product = display_list![index];
                                        Navigator.push(
                                            context,
                                            CustomPageRoute(
                                                child: ProductDetails(
                                              index: index,
                                              product: product,
                                            )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                                height: 90,
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                imageUrl:
                                                    products![index].image),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              products![index].title.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Price: ' +
                                                  products![index]
                                                      .price
                                                      .toString() +
                                                  '\$',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: hasMore
                                          ? CircularProgressIndicator()
                                          : Text('No more products available'));
                                }
                              })
                          : Text('No products found'))
                  : Container(
                      height: MediaQuery.of(context).size.height - 200,
                      child: Center(child: CircularProgressIndicator())),
            ],
          )),
    );
  }

  fetchProducts() async {
    products = await RemoteServices.getProducts(limit);
    print('length:${products!.length}');
    if (products != null) {
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      } else {
        print('Wait.....');
      }
    } else {
      print('Products are null');
    }
    display_list = products;
    if (display_list!.length < limit) {
      setState(() {
        hasMore = false;
      });
    }
    limit += 4;
  }

  void searchProduct(String value) {
    List<Product>? searchedProducts = products;

    setState(() {
      display_list = searchedProducts!
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
