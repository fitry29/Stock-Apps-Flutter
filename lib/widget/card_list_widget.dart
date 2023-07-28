import 'package:flutter/material.dart';

class CardListWidget extends StatelessWidget {
  final String name;
  final double price;
  final String date;
  final int qty;
  final void Function()? onTap;
  final Color iconColor;
  final Color cardColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: cardColor,
              border: Border.all(
                color: qty < 3 ? Colors.red : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 3.0,
                  spreadRadius: 1,
                  offset: Offset(1, 1),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Text(
                      "RM ${price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Text(date),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quantity: $qty",
                      style: TextStyle(
                        fontSize: 16,
                        color: iconColor,
                      ),
                    ),
                    IconButton(
                        onPressed: onTap,
                        icon: Icon(Icons.chevron_right_rounded))
                  ],
                )
              ],
            ),
          ),
          Visibility(
            visible: qty < 3 ? true : false,
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'Low Stock! Please add new stock',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }

  const CardListWidget(
      {Key? key,
      required this.name,
      required this.price,
      required this.date,
      required this.qty,
      this.onTap,
      this.iconColor = Colors.black,
      this.cardColor = Colors.white})
      : super(key: key);
}
