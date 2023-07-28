import 'package:flutter/material.dart';
import 'package:stockapps/widget/form_widget.dart';
import 'package:stockapps/widget/input_label_widget.dart';

class StockFormPage extends StatefulWidget {
  final String nama;
  final double harga;
  final int qty;
  final void Function(String)? onChangedNama;
  final void Function(String)? onChangedHarga;
  final void Function(String)? onChangedQty;
  final void Function()? onPressedAdd;
  final void Function()? onPressedRemove;

  const StockFormPage({
    Key? key,
    this.nama = '',
    this.harga = 0,
    this.qty = 0,
    this.onChangedNama,
    this.onChangedHarga,
    this.onChangedQty,
    this.onPressedAdd,
    this.onPressedRemove,
  }) : super(key: key);

  @override
  State<StockFormPage> createState() => _StockFormPageState();
}

class _StockFormPageState extends State<StockFormPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputLabelText(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              text: "Ingredient Name",
              fontSize: 16,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            buildName(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            InputLabelText(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              text: "Price (RM)",
              fontSize: 16,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            buildHarga(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            InputLabelText(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              text: "Quantity Stock",
              fontSize: 16,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            buildQtyCount(),
          ],
        ),
      ),
    );
  }

  Widget buildName() {
    return FormWidget(
      keyboardType: TextInputType.name,
      onTap: () {
        print(widget.nama);
      },
      initValue: widget.nama,
      fontSize: 16,
      hintText: "Name",
      validator: (name) =>
          name != null && name.isEmpty ? 'The Name Cannot be Empty' : null,
      onChanged: widget.onChangedNama,
    );
  }

  Widget buildHarga() {
    return FormWidget(
      keyboardType: TextInputType.number,
      onTap: () {
        print(widget.harga);
      },
      initValue: widget.harga == 0 ? null : widget.harga.toString(),
      fontSize: 16,
      hintText: "Enter Price",
      validator: (harga) =>
          harga != null && harga.isEmpty ? 'The Name Cannot be Empty' : null,
      onChanged: widget.onChangedHarga,
    );
  }

  Widget buildQty() {
    return FormWidget(
      keyboardType: TextInputType.number,
      onTap: () {
        print(widget.qty);
      },
      initValue: widget.qty == 0 ? null : widget.qty.toString(),
      fontSize: 16,
      hintText: "Harga",
      validator: (qty) =>
          qty != null && qty.isEmpty ? 'The Name Cannot be Empty' : null,
      onChanged: widget.onChangedQty,
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
        Text(widget.qty.toString()),
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
