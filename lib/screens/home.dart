import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:store/Model/model.dart';
import 'package:store/animation/screen_animation.dart';
import 'package:store/screens/details/product_details.dart';
import 'package:store/services/remote_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.isSearch}) : super(key: key);
  final bool isSearch;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var products;
  List? display_list;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  bool isLoaded = false;
  final searchText = TextEditingController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: SingleChildScrollView(
            child: Column(
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
                                itemCount: display_list!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CustomPageRoute(
                                                child: ProductDetails(
                                              index: index,
                                              product: display_list![index],
                                            )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Image(
                                              height: 90,
                                              image: NetworkImage(
                                                  display_list![index].image),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              products[index].title.toString(),
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
                                                  products[index]
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
                                })
                            : Text('No products found'),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Center(child: CircularProgressIndicator())),
              ],
            ),
          )),
    );
  }

  fetchProducts() async {
    products = await RemoteServices.getProducts();

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
  }

  void searchProduct(String value) {
    var searchedProducts = products as List;

    setState(() {
      display_list = searchedProducts
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
