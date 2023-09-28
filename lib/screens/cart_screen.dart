import 'package:flutter/material.dart';

import '../models/products_list.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return CartWidget(width: width, height: height);
  }
}

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final cartProducts =
      productsList.where((product) => product['isCart']).toList();
  int? totalSum;
  int? totalSumDot;
  String? totalPrice;
  String? totalPriceDot;
  void calcTotal() {
    totalSum = cartProducts.fold(0, (int? sum, product) {
      return sum! +
          (int.parse(
            product['price'].toString(),
          )); // Ensure 'price' is a double, and handle null values.
    });
    totalPrice = totalSum.toString();
    print(totalPrice);

    totalSumDot = cartProducts.fold(0, (int? sumDot, product) {
      return sumDot! +
          (int.parse(
            product['price_dot'].toString(),
          )); // Ensure 'price' is a double, and handle null values.
    });
    totalPriceDot = totalSumDot.toString();
    print(totalPriceDot);
  }

  @override
  void initState() {
    super.initState();
    calcTotal();
  }

  @override
  Widget build(BuildContext context) {
    if (cartProducts.isEmpty) {
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
              'Nothing In Cart',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Return To Home And Add Some To Cart.',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
            )
          ],
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartProducts.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(cartProducts[index]['id'].toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    // Toggle the 'isCart' property.
                    cartProducts[index]['isCart'] =
                        !cartProducts[index]['isCart'];

                    // Remove the item from the cartProducts list.
                    cartProducts.removeAt(index);

                    // Recalculate the total.
                    calcTotal();

                    print('removed');
                  });
                },
                background: Container(
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 7.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              cartProducts[index]['image'],
                            ),
                          ),
                        ),
                        width: widget.width * 0.4,
                        height: widget.height * 0.18,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              cartProducts[index]['Currency'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              cartProducts[index]['price'].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '.${cartProducts[index]['price_dot'].toString()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: widget.width * 0.535,
                          child: Text(
                            cartProducts[index]['describtion'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Row(
            children: [
              Text(
                totalPrice.toString(),
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '.${totalPriceDot.toString()}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                ' EGP',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(
                      widget.width * 0.52,
                      widget.height * 0.07,
                    ),
                  ),
                ),
                child: const Text(
                  'Check Out',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
