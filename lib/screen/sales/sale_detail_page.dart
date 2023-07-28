import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockapps/db/sales_db.dart';
import 'package:stockapps/model/sales.dart';
import 'package:stockapps/screen/sales/add_edit_sale_page.dart';
import 'package:stockapps/widget/elevated_button_widget.dart';

class SaleDetailPage extends StatefulWidget {
  final int saleId;
  const SaleDetailPage({
    Key? key,
    required this.saleId,
  }) : super(key: key);

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> {
  late Sale sales;
  bool isLoading = false;
  var formatter = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();

    refreshSales();
  }

  Future refreshSales() async {
    setState(() => isLoading = true);

    this.sales = await SaleDatabase.instance.readOrder(widget.saleId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
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
          ? Container(
              color: Colors.grey.shade100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sale Information',
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
            color: Colors.grey.shade200,
            blurRadius: 5,
            spreadRadius: 3,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sales.custName.toUpperCase(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Delivery :',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),
          Text(
            'RM ' + sales.delivery.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Product:',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),
          Text(
            sales.product,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Remark : ',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),
          Text(
            sales.remarks,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Quantity : ',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),
          Text(
            sales.unit.toString() + ' pcs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            'Total :',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.004,
          ),
          Text(
            'RM ' + sales.total.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            formatter.format(sales.saleDate),
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
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
                builder: (context) => AddEditSalePage(
                  sales: sales,
                ),
              ));

              refreshSales();
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
                await SaleDatabase.instance.delete(widget.saleId);

                refreshSales();
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
