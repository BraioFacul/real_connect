import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'usuario.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Criar tabela
        await db.execute('''
        CREATE TABLE usuario (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          ra TEXT,
          periodo TEXT,
          sala TEXT,
          contato TEXT,
          apelido TEXT
        )
      ''');

        // Inserir um usuário default
        await db.insert('usuario', {
          'nome': 'Usuário Padrão',
          'ra': '123456',
          'periodo': 'Noturno',
          'sala': '101',
          'contato': '123456789',
          'apelido': 'Padrão'
        });
      },
    );
  }

  // Inserir um novo aluno no banco de dados
  Future<int> inserirUsuario(Map<String, dynamic> aluno) async {
    var dbClient = await db;
    return await dbClient.insert('usuario', aluno);
  }

  // Buscar todos os usuários no banco de dados
  Future<List<Map<String, dynamic>>> getUsuarios() async {
    var dbClient = await db;
    return await dbClient.query('usuario');
  }

  Future<int> atualizarUsuario(Map<String, dynamic> aluno, int id) async {
    var dbClient = await db;
    return await dbClient
        .update('usuario', aluno, where: 'id = ?', whereArgs: [id]);
  }
}
