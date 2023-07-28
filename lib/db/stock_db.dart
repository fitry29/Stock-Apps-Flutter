import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stockapps/model/stock.dart';

class StockDatabase {
  static final StockDatabase instance = StockDatabase._init();

  static Database? _database;

  StockDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('stock.db');
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
CREATE TABLE $tableStock(
    ${StockFields.stockId} $idType,
    ${StockFields.nama} $textType,
    ${StockFields.harga} REAL,
    ${StockFields.qty} INTEGER,
    ${StockFields.createdTime} $textType
    )
''');
  }

  Future<Stock> create(Stock stock) async {
    final db = await instance.database;

    final stockId = await db.insert(tableStock, stock.toJson());
    return stock.copy(stockId: stockId);
  }

  Future<Stock> readOrder(int stockId) async {
    final db = await instance.database;

    final maps = await db.query(
      tableStock,
      columns: StockFields.values,
      where: '${StockFields.stockId} = ?',
      whereArgs: [stockId],
    );

    if (maps.isNotEmpty) {
      return Stock.fromJson(maps.first);
    } else {
      throw Exception("Id not found");
    }
  }

  Future<List<Stock>> readAllStock() async {
    final db = await instance.database;
    final orderBy = '${StockFields.stockId} ASC';
    final result = await db.query(tableStock, orderBy: orderBy);

    return result.map((json) => Stock.fromJson(json)).toList();
  }

  Future<int> update(Stock stock) async {
    final db = await instance.database;

    return db.update(tableStock, stock.toJson(),
        where: '${StockFields.stockId} = ?', whereArgs: [stock.stockId]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableStock,
      where: '${StockFields.stockId} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
