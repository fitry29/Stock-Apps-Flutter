import 'package:flutter/material.dart';
import 'package:stockapps/db/sales_db.dart';
import 'package:stockapps/model/sales.dart';
import 'package:stockapps/screen/sales/sale_form_page.dart';
import 'package:stockapps/widget/elevated_button_widget.dart';
import 'package:stockapps/widget/input_label_widget.dart';

class AddEditSalePage extends StatefulWidget {
  final Sale? sales;
  const AddEditSalePage({
    Key? key,
    this.sales,
  }) : super(key: key);

  @override
  State<AddEditSalePage> createState() => _AddEditSalePageState();
}

class _AddEditSalePageState extends State<AddEditSalePage> {
  final _formKey = GlobalKey<FormState>();
  late String custName;
  late DateTime saleDate;
  late int unit;
  late double delivery;
  late String product;
  late String remarks;
  late double total;

  @override
  void initState() {
    super.initState();

    custName = widget.sales?.custName ?? '';
    saleDate = widget.sales?.saleDate ?? DateTime.now();
    unit = widget.sales?.unit ?? 0;
    delivery = widget.sales?.delivery ?? 0;
    product = widget.sales?.product ?? "Chocolate Chip Cookies";
    remarks = widget.sales?.remarks ?? '';
    total = widget.sales?.total ?? 0;
  }

  double calculateTotal() {
    setState(() {
      total = (13 * unit) + delivery;
    });
    return total;
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.grey.shade100,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Row(
            //   children: [
            //     IconButton(
            //       icon: Icon(
            //         Icons.arrow_back_ios_new_rounded,
            //         color: Colors.black,
            //       ),
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //     ),
            //   ],
            // ),
            saleForm(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Center(child: buildButton()),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget saleForm() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Container(
        padding: EdgeInsets.fromLTRB(22, 20, 22, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5.0,
              spreadRadius: 3,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            InputLabelText(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              text: "SALE FORM",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Form(
              key: _formKey,
              child: SaleFormPage(
                custName: custName,
                delivery: delivery,
                unit: unit,
                product: product,
                remarks: remarks,
                total: calculateTotal(),
                saleDate: saleDate,
                onChangedNama: (custName) {
                  setState(() {
                    this.custName = custName;
                  });
                },
                onChangedDelivery: (delivery) {
                  setState(() {
                    this.delivery = double.parse(delivery);
                  });
                },
                onChangedProduct: (product) {
                  setState(() {
                    this.product = product;
                  });
                },
                onChangedRemark: (remarks) {
                  setState(() {
                    this.remarks = remarks;
                  });
                },
                onChangedTotal: (total) {
                  setState(() {
                    this.total = calculateTotal();
                  });
                },
                onChangedUnit: (unit) {
                  setState(() {
                    this.unit = int.parse(unit);
                  });
                },
                onPressedAdd: () {
                  setState(() {
                    unit++;
                  });
                  print(unit.toString());
                  print(product.toString());
                  print(calculateTotal().toString());
                },
                onPressedRemove: () {
                  setState(() {
                    if (unit > 0) {
                      unit--;
                    }
                    print(unit.toString());
                  });
                },
                onPressedDate: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: saleDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );

                  //IF CANCEL NOTHING HAPPEN
                  if (newDate == null) return;

                  //IF CONFIRM CHANGE DATE
                  setState(() {
                    saleDate = newDate;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = custName.isNotEmpty;

    return ElevatedButtonWidget(
      radius: 50,
      buttonColor:
          isFormValid ? Colors.yellowAccent.shade700 : Colors.grey.shade500,
      onPressed: addOrUpdateSales,
      text: "Save",
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
    );
  }

  void addOrUpdateSales() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.sales != null;

      if (isUpdating) {
        await updateSales();
      } else {
        await addSales();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateSales() async {
    final sale = widget.sales!.copy(
      custName: custName,
      delivery: delivery,
      product: product,
      remarks: remarks,
      saleDate: saleDate,
      total: total,
      unit: unit,
    );

    await SaleDatabase.instance.update(sale);
  }

  Future addSales() async {
    final sale = Sale(
      custName: custName,
      delivery: delivery,
      product: product,
      remarks: remarks,
      saleDate: saleDate,
      total: total,
      unit: unit,
    );

    await SaleDatabase.instance.create(sale);
  }
}
