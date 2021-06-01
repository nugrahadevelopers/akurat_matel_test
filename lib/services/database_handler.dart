import 'package:akurat_matel/models/car_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'kendaraan.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE cars(id TEXT PRIMARY KEY NOT NULL, nopol TEXT NOT NULL, jenis TEXT NOT NULL, finance TEXT NOT NULL, cabang TEXT NOT NULL, atas_nama TEXT NOT NULL, no_kontrak TEXT NOT NULL, no_mesin TEXT NOT NULL, no_rangka TEXT NOT NULL, warna TEXT NOT NULL, over_due TEXT NOT NULL, saldo TEXT NOT NULL)");
      },
      version: 1,
    );
  }

  Future<int> insertCar(List<CarModel> cars) async {
    int result = 0;
    final Database db = await initDB();
    for (var car in cars) {
      try {
        result = await db.insert('cars', car.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (error) {
        print('Error db insert: $error');
      }
    }
    return result;
  }

  Future<List<CarModel>> retrieveCar() async {
    final Database db = await initDB();
    final List<Map<String, Object>> queryResult = await db.query('cars');
    return queryResult.map((e) => CarModel.fromJson(e)).toList();
  }
}
