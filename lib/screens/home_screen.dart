import 'package:e_commerce/screens/product_details.dart';
import 'package:flutter/material.dart';

import '../models/products_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: ProductCard(width: width, height: height),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Search',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: GridView.builder(
            itemCount: productsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductDetails(
                          imageUrl: productsList[index]['image'],
                          price: productsList[index]['price'].toString(),
                          describtion: productsList[index]['describtion'],
                          currency: productsList[index]['Currency'],
                          priceDot: productsList[index]['price_dot'].toString(),
                          productsList: productsList,
                          index: index,
                        );
                      },
                    ),
                  );
                },
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  productsList[index]['image'],
                                ),
                              ),
                            ),
                            width: widget.width * 0.46,
                            height: widget.height * 0.2,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Text(
                              productsList[index]['Currency'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              productsList[index]['price'].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '.${productsList[index]['price_dot'].toString()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  productsList[index]['isCart'] =
                                      !productsList[index]['isCart'];
                                });
                                final message = productsList[index]['isCart']
                                    ? 'Added to Cart'
                                    : 'Removed from Cart';

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    duration: const Duration(
                                      seconds: 2,
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                productsList[index]['isCart']
                                    ? Icons.shopping_cart
                                    : Icons.shopping_cart_outlined,
                                size: 20,
                                color: productsList[index]['isCart']
                                    ? Colors.green
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  productsList[index]['isFavorite'] =
                                      !productsList[index]['isFavorite'];
                                });
                                final message = productsList[index]
                                        ['isFavorite']
                                    ? 'Added to favorites'
                                    : 'Removed from favorites';

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    duration: const Duration(
                                      seconds: 2,
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                productsList[index]['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 20,
                                color: productsList[index]['isFavorite']
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            const Text('تم البيع'),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(productsList[index]['counter_buy']),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(productsList[index]['rating']),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          productsList[index]['describtion'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
