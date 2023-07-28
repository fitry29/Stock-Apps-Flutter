final String tableStock = "stocks";

class StockFields {
  static final List<String> values = [
    stockId,
    nama,
    harga,
    qty,
    createdTime,
  ];

  static final String stockId = '_stockId';
  static final String nama = 'nama';
  static final String harga = 'harga';
  static final String qty = 'qty';
  static final String createdTime = 'createdTime';
}

class Stock {
  final int? stockId;
  final String nama;
  final double harga;
  final int qty;
  final DateTime createdTime;

  const Stock({
    this.stockId,
    required this.nama,
    required this.harga,
    required this.qty,
    required this.createdTime,
  });

  Stock copy({
    int? stockId,
    String? nama,
    double? harga,
    int? qty,
    DateTime? createdTime,
  }) =>
      Stock(
        stockId: stockId ?? this.stockId,
        harga: harga ?? this.harga,
        nama: nama ?? this.nama,
        createdTime: createdTime ?? this.createdTime,
        qty: qty ?? this.qty,
      );

  static Stock fromJson(Map<String, Object?> json) => Stock(
        stockId: json[StockFields.stockId] as int?,
        nama: json[StockFields.nama] as String,
        harga: double.parse(json[StockFields.harga].toString()),
        qty: int.parse(json[StockFields.qty].toString()),
        createdTime: DateTime.parse(json[StockFields.createdTime] as String),
      );

  Map<String, Object?> toJson() => {
        StockFields.stockId: stockId,
        StockFields.nama: nama,
        StockFields.harga: harga,
        StockFields.qty: qty,
        StockFields.createdTime: createdTime.toIso8601String(),
      };
}
