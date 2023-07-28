import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockapps/widget/elevated_button_widget.dart';
import 'package:stockapps/widget/form_widget.dart';
import 'package:stockapps/widget/input_label_widget.dart';

class SaleFormPage extends StatefulWidget {
  final String custName;
  final DateTime saleDate;
  final int unit;
  final double delivery;
  final String product;
  final String remarks;
  final double total;
  final void Function(String)? onChangedNama;
  final void Function(String)? onChangedUnit;
  final void Function(String)? onChangedDelivery;
  final void Function(String)? onChangedProduct;
  final void Function(String)? onChangedRemark;
  final void Function(String)? onChangedTotal;
  final void Function()? onPressedAdd;
  final void Function()? onPressedRemove;
  final void Function()? onPressedDate;

  const SaleFormPage({
    Key? key,
    this.custName = '',
    required this.saleDate,
    this.unit = 0,
    this.delivery = 0,
    this.product = '',
    this.remarks = '',
    this.total = 0,
    this.onChangedNama,
    this.onChangedUnit,
    this.onChangedDelivery,
    this.onChangedProduct,
    this.onChangedRemark,
    this.onChangedTotal,
    this.onPressedAdd,
    this.onPressedRemove,
    this.onPressedDate,
  }) : super(key: key);

  @override
  State<SaleFormPage> createState() => _SaleFormPageState();
}

class _SaleFormPageState extends State<SaleFormPage> {
  double totalCalcuate() {
    double totalALL = 0;
    int qty = widget.unit;

    totalALL = (13 * qty) + widget.delivery;

    return totalALL;
  }

  @override
  void initState() {
    super.initState();

    totalCalcuate();
  }

  @override
  Widget build(BuildContext context) {
    var formCard = [
      buildName(),
      buildDate(),
      buildDelivery(),
      buildProduct(),
      buildRemark(),
      buildQtyCount(),
      buildTotal(),
    ];

    var listName = [
      "Customer Name",
      "Date",
      "Delivery Charges",
      "Products",
      "Remark",
      "Quantity",
      "Total",
    ];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < listName.length; i++)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputLabelText(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      text: listName[i],
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      child: formCard[i],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget buildName() {
    return FormWidget(
      keyboardType: TextInputType.name,
      onTap: () {
        print(widget.custName);
      },
      initValue: widget.custName,
      fontSize: 16,
      hintText: "Name",
      validator: (custName) => custName != null && custName.isEmpty
          ? 'The Name Cannot be Empty'
          : null,
      onChanged: widget.onChangedNama,
    );
  }

  Widget buildUnit() {
    return FormWidget(
      keyboardType: TextInputType.number,
      onTap: () {
        print(widget.unit);
      },
      initValue: widget.unit.toString(),
      fontSize: 16,
      hintText: "Unit",
      validator: (unit) =>
          unit != null && unit.isEmpty ? 'The unit Cannot be Empty' : null,
      onChanged: widget.onChangedNama,
    );
  }

  Widget buildDelivery() {
    return FormWidget(
      keyboardType: TextInputType.number,
      onTap: () {
        print(widget.delivery);
      },
      initValue: widget.delivery == 0 ? '' : widget.delivery.toString(),
      fontSize: 16,
      hintText: "Delivery Charges (RM)",
      validator: (delivery) => delivery != null && delivery.isEmpty
          ? 'The delivery Cannot be Empty'
          : null,
      onChanged: widget.onChangedDelivery,
    );
  }

  Widget buildProduct() {
    return FormWidget(
      keyboardType: TextInputType.text,
      onTap: () {
        print(widget.product);
      },
      initValue: widget.product,
      fontSize: 16,
      hintText: "Product",
      validator: (product) => product != null && product.isEmpty
          ? 'The product Cannot be Empty'
          : null,
      onChanged: widget.onChangedProduct,
    );
  }

  Widget buildRemark() {
    return FormWidget(
      keyboardType: TextInputType.text,
      onTap: () {
        print(widget.remarks);
      },
      initValue: widget.remarks,
      fontSize: 16,
      hintText: "Remarks",
      onChanged: widget.onChangedRemark,
    );
  }

  Widget buildTotal() {
    return FormWidget(
      oNtap: () {
        setState(() {
          totalCalcuate();
        });
      },
      keyboardType: TextInputType.number,
      onTap: () {
        print(widget.total);
        setState(() {
          widget.total.toString();
        });
      },
      controller: TextEditingController()..text = widget.total.toString(),
      //initValue: widget.total.toString(),
      fontSize: 16,
      hintText: "Total",
      validator: (total) =>
          total != null && total.isEmpty ? 'The remarks Cannot be Empty' : null,
      onChanged: widget.onChangedTotal,
    );
  }

  Widget buildDate() {
    var formatter = DateFormat('d MMM yyyy');
    String formattedDate = formatter.format(widget.saleDate);
    return ElevatedButtonWidget(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.35,
      buttonColor: Colors.yellow,
      text: formattedDate.toString(),
      onPressed: widget.onPressedDate,
    );
  }

  Widget buildQtyCount() {
    return Row(
      children: [
        IconButton(
          onPressed: widget.onPressedRemove,
          icon: Icon(
            Icons.remove,
            color: Colors.black,
          ),
        ),
        Text(widget.unit.toString()),
        IconButton(
          onPressed: widget.onPressedAdd,
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
