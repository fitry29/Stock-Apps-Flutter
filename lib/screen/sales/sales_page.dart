import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:stockapps/db/sales_db.dart';
import 'package:stockapps/model/sales.dart';
import 'package:stockapps/screen/sales/add_edit_sale_page.dart';
import 'package:stockapps/screen/sales/sale_detail_page.dart';
import 'package:stockapps/widget/card_list_widget.dart';
import 'package:stockapps/widget/card_list_widget_II.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  late List<Sale> sales;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshSales();
  }

  Future refreshSales() async {
    setState(() => isLoading = true);

    this.sales = await SaleDatabase.instance.readAllSale();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _buildAppBar(),
      body: isLoading
          ? Container(
              color: Colors.grey.shade100,
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            )
          : sales.isEmpty
              ? Container(
                  color: Colors.grey.shade100,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/no_item.png'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        'No Sales',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                )
              : buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "Sales Page",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.grey.shade100,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.download_rounded),
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddEditSalePage()),
              );

              refreshSales();
            },
            icon: Icon(Icons.add),
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.shade100,
        // height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5.0,
                    spreadRadius: 3,
                    offset: Offset(1, 1),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                "Sales List",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            buildList(),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
//     return GroupedListView<dynamic, DateTime>(
//       elements: sales,
//       groupBy: (element) => element["saleDate"],
//       groupSeparatorBuilder: (value) {
//         String date = DateFormat('MMMM, EEEE').format(value);
//         return Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(16),
//           color: Colors.white,
//           child: Text(date),
//         );
//       },
//       shrinkWrap: true,
//  indexedItemBuilder: (context, element, index) {
   
//  },
//     );
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sales.length,
      itemBuilder: (context, index) {
        final sale = sales[index];
        var formatter = DateFormat('dd MMM yyyy');
        var formatter2 = DateFormat('dd MMM yyyy');
        String formattedDate = formatter.format(sale.saleDate);

        return CardListWidgetII(
          name: sale.custName,
          price: sale.total,
          date: formattedDate,
          qty: sale.unit,
          onTap: () async {
            print("Yehaa");
            print(jsonEncode(sale));
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => SaleDetailPage(saleId: sale.saleId!)),
            );

            refreshSales();
          },
        );
        // return Container(
        //   child: Text(sale.custName),
        // );
      },
    );
  }
}
