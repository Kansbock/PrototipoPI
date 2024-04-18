import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '127.0.0.1',
      user = 'root',
      password = '23.01182-3',
      db = 'eureka_2023';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
