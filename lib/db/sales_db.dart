import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stockapps/model/sales.dart';

class SaleDatabase {
  static final SaleDatabase instance = SaleDatabase._init();

  static Database? _database;

  SaleDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('sale.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT NOT NULL";

    await db.execute('''
CREATE TABLE $tableSale(
  ${SaleFields.saleId} $idType,
  ${SaleFields.custName} $textType,
  ${SaleFields.saleDate} $textType,
  ${SaleFields.unit} INTEGER,
  ${SaleFields.delivery} REAL,
  ${SaleFields.product} $textType,
  ${SaleFields.remarks} $textType,
  ${SaleFields.total} REAL
)
''');
  }

  Future<Sale> create(Sale sale) async {
    final db = await instance.database;

    final saleId = await db.insert(tableSale, sale.toJson());
    return sale.copy(saleId: saleId);
  }

  Future<Sale> readOrder(int saleId) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSale,
      columns: SaleFields.values,
      where: '${SaleFields.saleId} = ?',
      whereArgs: [saleId],
    );

    if (maps.isNotEmpty) {
      return Sale.fromJson(maps.first);
    } else {
      throw Exception("Id not found");
    }
  }

  Future<List<Sale>> readAllSale() async {
    final db = await instance.database;
    final orderBy = '${SaleFields.saleDate} DESC';
    final result = await db.query(tableSale, orderBy: orderBy);

    return result.map((json) => Sale.fromJson(json)).toList();
  }

  Future<int> update(Sale sale) async {
    final db = await instance.database;

    return db.update(tableSale, sale.toJson(),
        where: '${SaleFields.saleId} = ?', whereArgs: [sale.saleId]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableSale,
      where: '${SaleFields.saleId} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
