import 'package:app_bangiay_doan/data/models/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _databaseService = DatabaseHelper._internal();
  factory DatabaseHelper() => _databaseService;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'db_cart.db');
    print(
        "Đường dẫn database: $databasePath"); // in đường dẫn chứa file database
    return await openDatabase(path, onCreate: _onCreate, version: 1
      // ,
      // onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE Cart('
      'productID INTEGER PRIMARY KEY, '
      'name TEXT, '
      'price FLOAT, '
      'img TEXT, '
      'des TEXT, '
      'count INTEGER)',
    );
  }
  Future<void> _deleteTable(String tableName) async {
    final db = await database;
    await db.execute('DROP TABLE IF EXISTS $tableName');
  }
  Future<void> _createTable(String tableName) async {
    final db = await database;
    await _deleteTable(tableName); // Xóa bảng cũ trước khi tạo mới
    await _onCreate(db, 1); // Tạo lại bảng mới
  }
    Future<void> deleteAndCreateTable() async {
    await _deleteTable('Cart'); // Xóa bảng 'Cart'
    await _createTable('Cart'); // Tạo lại bảng 'Cart'
  }

  Future<void> insertProduct(Cart productModel) async {
    final db = await _databaseService.database;
    await db.insert(
      'Cart',
      productModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Cart>> products() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('Cart');
    return List.generate(
        maps.length, (index) => Cart.fromMap(maps[index]));
  }
  Future<Cart> product(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
    await db.query('product', where: 'id = ?', whereArgs: [id]);
    return Cart.fromMap(maps[0]);
  }


   Future<void> minus(Cart product) async {
    final db = await _databaseService.database;
    if(product.count  > 1) product.count--;
    await db.update(
      'Cart',
      product.toMap(),
      where: 'productID = ?',
      whereArgs: [product.productID],
    );
  }
  Future<void> add(Cart product) async {
    final db = await _databaseService.database;
    product.count++;
    await db.update(
      'Cart',
      product.toMap(),
      where: 'productID = ?',
      whereArgs: [product.productID],
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'Cart',
      where: 'productID = ?',
      whereArgs: [id],
    );
  }
  
  Future<void> clear() async {
    final db = await _databaseService.database;
    await db.delete(
      'Cart',
      where: 'count > 0'
    );
  }
   Future<List<int>> getFavoriteProductIds() async {
    // Retrieve favorite product IDs from the database
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) => maps[i]['productID']);
  }

  updateProduct(int productID, int quantity) {}
}
