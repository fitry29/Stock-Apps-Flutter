final String tableSale = "sales";

class SaleFields {
  static final List<String> values = [
    saleId,
    custName,
    saleDate,
    unit,
    delivery,
    product,
    remarks,
    total,
  ];

  static final String saleId = "_saleId";
  static final String custName = "custName";
  static final String saleDate = "saleDate";
  static final String unit = "unit";
  static final String delivery = "delivery";
  static final String product = "product";
  static final String remarks = "remarks";
  static final String total = "total";
}

class Sale {
  final int? saleId;
  final String custName;
  final DateTime saleDate;
  final int unit;
  final double delivery;
  final String product;
  final String remarks;
  final double total;

  const Sale({
    this.saleId,
    required this.custName,
    required this.saleDate,
    required this.unit,
    required this.delivery,
    required this.product,
    required this.remarks,
    required this.total,
  });

  Sale copy({
    int? saleId,
    String? custName,
    DateTime? saleDate,
    int? unit,
    double? delivery,
    String? product,
    String? remarks,
    double? total,
  }) =>
      Sale(
        saleId: saleId ?? this.saleId,
        custName: custName ?? this.custName,
        saleDate: saleDate ?? this.saleDate,
        unit: unit ?? this.unit,
        delivery: delivery ?? this.delivery,
        product: product ?? this.product,
        remarks: remarks ?? this.remarks,
        total: total ?? this.total,
      );

  static Sale fromJson(Map<String, Object?> json) => Sale(
        saleId: json[SaleFields.saleId] as int?,
        custName: json[SaleFields.custName] as String,
        saleDate: DateTime.parse(json[SaleFields.saleDate] as String),
        unit: int.parse(json[SaleFields.unit].toString()),
        delivery: double.parse(json[SaleFields.delivery].toString()),
        product: json[SaleFields.product] as String,
        remarks: json[SaleFields.remarks] as String,
        total: double.parse(json[SaleFields.total].toString()),
      );

  Map<String, Object?> toJson() => {
        SaleFields.saleId: saleId,
        SaleFields.custName: custName,
        SaleFields.saleDate: saleDate.toIso8601String(),
        SaleFields.unit: unit,
        SaleFields.delivery: delivery,
        SaleFields.product: product,
        SaleFields.remarks: remarks,
        SaleFields.total: total,
      };
}
