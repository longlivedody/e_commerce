import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.describtion,
    required this.currency,
    required this.priceDot,
    required this.productsList,
    required this.index,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
  final String imageUrl;
  final String price;
  final String describtion;
  final String currency;
  final String priceDot;
  final List<Map<dynamic, dynamic>> productsList;
  final int index;
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.imageUrl),
                ),
              ),
              width: double.infinity,
              height: 250,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.currency,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '.${widget.priceDot}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.productsList[widget.index]['isCart'] =
                            !widget.productsList[widget.index]['isCart'];
                      });
                      final message = widget.productsList[widget.index]
                              ['isCart']
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
                      widget.productsList[widget.index]['isCart']
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined,
                      size: 20,
                      color: widget.productsList[widget.index]['isCart']
                          ? Colors.green
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.productsList[widget.index]['isFavorite'] =
                            !widget.productsList[widget.index]['isFavorite'];
                      });
                      final message = widget.productsList[widget.index]
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
                      widget.productsList[widget.index]['isFavorite']
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      size: 20,
                      color: widget.productsList[widget.index]['isFavorite']
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.productsList[widget.index]['describtion'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              indent: 20.0,
              endIndent: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
