import 'package:e_commerce/models/products_list.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
    final favoriteProducts =
        productsList.where((product) => product['isFavorite']).toList();
    if (favoriteProducts.isEmpty) {
      // Display a message when there are no favorite products.
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 230,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://img.freepik.com/free-vector/flat-design-complain-concept_23-2148946030.jpg?w=826&t=st=1695777684~exp=1695778284~hmac=bf8c9a0e5d02794c7765dc449953587d287b1a8f54e462aa2df6cd236964d4f8',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'No Favorite Yet',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Return To Home And Add Some Favorites.',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            )
          ],
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
              itemCount: favoriteProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 15.0,
              ),
              itemBuilder: (context, index) {
                return SizedBox(
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
                                  favoriteProducts[index]['image'],
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
                              favoriteProducts[index]['Currency'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              favoriteProducts[index]['price'].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '.${favoriteProducts[index]['price_dot'].toString()}',
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
                                  favoriteProducts[index]['isFavorite'] =
                                      !favoriteProducts[index]['isFavorite'];
                                });
                                favoriteProducts.removeAt(index);
                              },
                              child: Icon(
                                favoriteProducts[index]['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 20,
                                color: favoriteProducts[index]['isFavorite']
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
                            Text(favoriteProducts[index]['counter_buy']),
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
                            Text(favoriteProducts[index]['rating']),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          favoriteProducts[index]['describtion'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
