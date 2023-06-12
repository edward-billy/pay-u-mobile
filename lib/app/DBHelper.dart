import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:payu/app/cart.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

// creating database table
  // _onCreate(Database db, int version) async {
  //   await db.execute(
  //       'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, unitTag TEXT, image TEXT)');
  // }
  _onCreate(Database db, int version) async {
    String tableName = "cart";
    String columnId = "id";
    String columnProductId = "productId";
    String columnProductName = "productName";
    String columnInitialPrice = "initialPrice";
    String columnProductPrice = "productPrice";
    String columnQuantity = "quantity";
    String columnKategori = "kategori"; // Ubah nama kolom menjadi "kategori"
    String columnImage = "image";

    await db.execute('''
    CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY,
      $columnProductId VARCHAR UNIQUE,
      $columnProductName TEXT,
      $columnInitialPrice INTEGER,
      $columnProductPrice INTEGER,
      $columnQuantity INTEGER,
      $columnKategori TEXT, // Ubah nama kolom menjadi "kategori"
      $columnImage TEXT
    )
  ''');
    print("terbuat");
  }

// inserting data into the table
  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

// getting all the items in the list from the database
  // Future<List<Cart>> getCartList() async {
  //   var dbClient = await database;
  //   final List<Map<String, Object?>> queryResult =
  //       await dbClient!.query('cart');
  //   return queryResult.map((result) => Cart.fromMap(result)).toList();
  // }
  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    if (dbClient != null) {
      final List<Map<String, Object?>> queryResult =
          await dbClient.query('cart');
      return queryResult.map((result) => Cart.fromMap(result)).toList();
    } else {
      // Handle the case where the database is null
      return []; // Return an empty list or an appropriate error response
    }
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('cart', cart.toMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
