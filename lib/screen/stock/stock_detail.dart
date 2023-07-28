import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockapps/db/stock_db.dart';
import 'package:stockapps/model/stock.dart';
import 'package:stockapps/screen/stock/add_edit_stock_page.dart';
import 'package:stockapps/widget/elevated_button_widget.dart';

class StockDetailPage extends StatefulWidget {
  final int stockId;
  const StockDetailPage({
    Key? key,
    required this.stockId,
  }) : super(key: key);

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  late Stock stock;
  bool isLoading = false;
  var formatter = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();

    refreshStocks();
  }

  String totalPrice() {
    double total = 0;
    total = stock.harga * stock.qty;
    return total.toStringAsFixed(2);
  }

  Future refreshStocks() async {
    setState(() => isLoading = true);

    this.stock = await StockDatabase.instance.readOrder(widget.stockId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Stock Information',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          detailContent(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          buildButton()
        ],
      ),
    );
  }

  Widget detailContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 3.0,
            spreadRadius: 0.5,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingridient Name: ' + stock.nama,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Price: RM' + stock.harga.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Quantity: ' + stock.qty.toString(),
            style: TextStyle(
              fontSize: 20,
              color: stock.qty < 3 ? Colors.red : Colors.black,
            ),
          ),
          Visibility(
              visible: stock.qty < 3 ? true : false,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Low Stock! Please add new stock',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Total Price: RM' + totalPrice(),
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Update at ' + formatter.format(stock.createdTime),
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButtonWidget(
            onPressed: () async {
              print("Tekan");
              if (isLoading) return;

              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddEditStockPage(
                  stock: stock,
                ),
              ));

              refreshStocks();
            },
            buttonColor: Colors.yellowAccent.shade400,
            text: "Edit",
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: IconButton(
              onPressed: () async {
                await StockDatabase.instance.delete(widget.stockId);

                refreshStocks();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
