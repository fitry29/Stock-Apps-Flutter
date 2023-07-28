import 'package:flutter/material.dart';
import 'package:stockapps/db/stock_db.dart';
import 'package:stockapps/model/stock.dart';
import 'package:stockapps/screen/stock/stock_form_page.dart';
import 'package:stockapps/widget/elevated_button_widget.dart';
import 'package:stockapps/widget/input_label_widget.dart';

class AddEditStockPage extends StatefulWidget {
  final Stock? stock;
  const AddEditStockPage({
    Key? key,
    this.stock,
  }) : super(key: key);

  @override
  State<AddEditStockPage> createState() => _AddEditStockPageState();
}

class _AddEditStockPageState extends State<AddEditStockPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late double harga;
  late int qty;

  @override
  void initState() {
    super.initState();

    name = widget.stock?.nama ?? '';
    harga = widget.stock?.harga ?? 0;
    qty = widget.stock?.qty ?? 0;
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            InputLabelText(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              text: "Stock Form",
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Form(
              key: _formKey,
              child: StockFormPage(
                onChangedHarga: (harga) {
                  setState(() {
                    this.harga = double.parse(harga);
                  });
                },
                onChangedQty: (qty) {
                  setState(() {
                    this.qty = int.parse(qty);
                  });
                },
                nama: name,
                harga: harga,
                qty: qty,
                onChangedNama: (name) {
                  setState(() {
                    this.name = name;
                  });
                },
                onPressedAdd: () {
                  setState(() {
                    qty++;
                  });
                  print(qty.toString());
                },
                onPressedRemove: () {
                  setState(() {
                    if (qty > 0) {
                      qty--;
                    } else {
                      qty = qty;
                    }
                    print(qty.toString());
                  });
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Center(child: buildButton()),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = name.isNotEmpty;

    return ElevatedButtonWidget(
      radius: 50,
      buttonColor:
          isFormValid ? Colors.yellowAccent.shade700 : Colors.grey.shade500,
      onPressed: addOrUpdateStock,
      text: "Save",
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.06,
    );

    // return Padding(
    //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    //   child: ElevatedButton(
    //     style: ElevatedButton.styleFrom(
    //       onPrimary: Colors.white,
    //       primary: isFormValid ? null : Colors.grey.shade700,
    //     ),
    //     onPressed: addOrUpdateStock,
    //     child: Text('Save'),
    //   ),
    // );
  }

  void addOrUpdateStock() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.stock != null;

      if (isUpdating) {
        await updateStock();
      } else {
        await addStock();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateStock() async {
    final stock = widget.stock!.copy(
      nama: name,
      harga: harga,
      qty: qty,
    );

    await StockDatabase.instance.update(stock);
  }

  Future addStock() async {
    final stock = Stock(
      nama: name,
      harga: harga,
      qty: qty,
      createdTime: DateTime.now(),
    );

    await StockDatabase.instance.create(stock);
  }
}
