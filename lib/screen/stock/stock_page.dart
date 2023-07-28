import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockapps/db/stock_db.dart';
import 'package:stockapps/model/stock.dart';
import 'package:stockapps/save_mobile.dart';
import 'package:stockapps/screen/stock/add_edit_stock_page.dart';
import 'package:stockapps/screen/stock/stock_detail.dart';
import 'package:stockapps/widget/card_list_widget.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late List<Stock> stocks;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshStocks();
  }

  // @override
  // void dispose() {
  //   StockDatabase.instance.close();

  //   super.dispose();
  // }

  String calculateTotal() {
    double totalItem = 0;
    double total = 0;
    for (int i = 0; i < stocks.length; i++) {
      totalItem = stocks[i].harga * stocks[i].qty;
      total = totalItem + total;
    }
    return 'RM ' + total.toStringAsFixed(2);
  }

  Future refreshStocks() async {
    setState(() => isLoading = true);

    this.stocks = await StockDatabase.instance.readAllStock();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            )
          : stocks.isEmpty
              ? Container(
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
                        'No Stock',
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                )
              : buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        //height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          children: [
            stockDashboard(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                "Stock List",
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

  Widget stockDashboard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.43,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.lightGreen[600],
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 3.0,
                spreadRadius: 1,
                offset: Offset(2, 2),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Stock (RM)',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Text(
                calculateTotal(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.43,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.green[700],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 3.0,
                spreadRadius: 1,
                offset: Offset(2, 2),
              )
            ],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TBD',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
              Text(
                'RM TBD',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "Stock Page",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: IconButton(
            onPressed: () {
              _createPDF();
            },
            icon: Icon(Icons.download_rounded),
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddEditStockPage()),
              );

              refreshStocks();
            },
            icon: Icon(Icons.add),
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];
        var formatter = DateFormat('dd MMM yyyy');
        String formattedDate = formatter.format(stock.createdTime);

        return CardListWidget(
          price: stock.harga,
          date: formattedDate,
          name: stock.nama,
          qty: stock.qty,
          onTap: () async {
            print("Yehaa");
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      StockDetailPage(stockId: stock.stockId!)),
            );

            refreshStocks();
          },
        );

        // return GestureDetector(
        //   onTap: () async {
        //     await Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => AddEditStockPage(),
        //       ),
        //     );
        //     refreshStocks();
        //   },
        //   child: Text(stock.nama),
        // );
      },
    );
  }

  Future<void> _createPDF() async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd MMM yyyy');
    String formattedDate = formatter.format(now);

    PdfDocument document = PdfDocument();

    final page = document.pages.add();

    page.graphics.drawString(
        "Stock Report Fyt's Cookies",
        PdfStandardFont(
          PdfFontFamily.timesRoman,
          17,
          style: PdfFontStyle.bold,
        ),
        brush: PdfBrushes.black);

    page.graphics.drawString(
      'Date : $formattedDate',
      PdfStandardFont(PdfFontFamily.timesRoman, 17),
      bounds: Rect.fromLTRB(350, 0, 0, 0),
    );
    page.graphics.drawString(
      'Total Stock (RM) : ' + calculateTotal(),
      PdfStandardFont(PdfFontFamily.timesRoman, 15),
      bounds: Rect.fromLTRB(0, 30, 0, 0),
    );

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 5);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];

    header.cells[0].value = 'Date';
    header.cells[1].value = 'Product';
    header.cells[2].value = 'Unit';
    header.cells[3].value = 'Price(RM)';
    header.cells[4].value = 'Total Price(RM)';

    for (int i = 0; i < 5; i++) {
      header.cells[i].style.font = PdfStandardFont(
        PdfFontFamily.timesRoman,
        12,
        style: PdfFontStyle.bold,
      );
      header.cells[i].style.backgroundBrush = PdfBrushes.aliceBlue;
    }

    for (int i = 0; i < stocks.length; i++) {
      String date = formatter.format(stocks[i].createdTime);
      var total = stocks[i].harga * stocks[i].qty;

      PdfGridRow row = grid.rows.add();
      row.cells[0].value = date;
      row.cells[1].value = stocks[i].nama;
      row.cells[2].value = stocks[i].qty.toString();
      row.cells[3].value = stocks[i].harga.toStringAsFixed(2);
      row.cells[4].value = total.toStringAsFixed(2);
    }

    // PdfGridRow row = grid.rows.add();
    // row.cells[0].value = '1';
    // row.cells[1].value = 'Arya';
    // row.cells[2].value = '6';

    grid.draw(
        page: document.pages[0], bounds: const Rect.fromLTWH(0, 60, 0, 0));

    List<int> bytes = document.saveSync();
    document.dispose();

    saveAndLaunch(bytes, 'Output.pdf');
  }
}
