import 'package:real_connect/models/aluno.dart';
import 'package:real_connect/models/user.dart';
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
        print("Criando tabelas...");

        await db.execute('DROP TABLE IF EXISTS user');
        await db.execute('DROP TABLE IF EXISTS aluno');

        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            sobrenome TEXT NOT NULL,
            senha TEXT NOT NULL,
            idade INTEGER NOT NULL,
            email TEXT UNIQUE NOT NULL,
            data_nascimento TEXT NOT NULL,
            sexo TEXT,
            endereco TEXT,
            cidade TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE materias (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            situacao TEXT,
            media REAL
          )
          ''');

        await db.execute('''
          CREATE TABLE aluno (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ra TEXT UNIQUE NOT NULL,
            periodo TEXT NOT NULL,
            curso TEXT NOT NULL,
            user_id INTEGER,
            FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
          )
        ''');

        await db.execute('''
          CREATE TABLE inscricao_image (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imagePath TEXT NOT NULL,
            tipo TEXT NOT NULL
          )
        ''');

        await db.insert('user', {
          'nome': 'João',
          'sobrenome': 'Silva',
          'senha': 'senha123',
          'idade': 25,
          'email': 'joao.silva@example.com',
          'data_nascimento': '1998-05-10',
          'sexo': 'M',
          'endereco': 'Rua das Flores, 123',
          'cidade': 'São Paulo',
        });

        await db.insert('user', {
          'nome': 'Maria',
          'sobrenome': 'Oliveira',
          'senha': 'senha456',
          'idade': 30,
          'email': 'maria.oliveira@example.com',
          'data_nascimento': '1993-08-15',
          'sexo': 'F',
          'endereco': 'Av. Brasil, 456',
          'cidade': 'Rio de Janeiro',
        });

        await db.insert('user', {
          'nome': 'Carlos',
          'sobrenome': 'Santos',
          'senha': 'senha789',
          'idade': 22,
          'email': 'carlos.santos@example.com',
          'data_nascimento': '2001-01-20',
          'sexo': 'M',
          'endereco': 'Rua da Paz, 789',
          'cidade': 'Belo Horizonte',
        });

        await db.insert('user', {
          'nome': 'Ana',
          'sobrenome': 'Costa',
          'senha': 'senha101',
          'idade': 28,
          'email': 'ana.costa@example.com',
          'data_nascimento': '1995-07-25',
          'sexo': 'F',
          'endereco': 'Rua Alegre, 321',
          'cidade': 'Curitiba',
        });

        await db.insert('user', {
          'nome': 'Pedro',
          'sobrenome': 'Lima',
          'senha': 'senha202',
          'idade': 35,
          'email': 'pedro.lima@example.com',
          'data_nascimento': '1988-11-30',
          'sexo': 'M',
          'endereco': 'Av. Paulista, 1001',
          'cidade': 'São Paulo',
        });

        await db.insert('aluno', {
          'ra': '123456',
          'periodo': 'Noturno',
          'curso': 'Engenharia de Software',
          'user_id': 1,
        });

        await db.insert('aluno', {
          'ra': '789012',
          'periodo': 'Diurno',
          'curso': 'Administração',
          'user_id': 2,
        });

        await db.insert('aluno', {
          'ra': '345678',
          'periodo': 'Noturno',
          'curso': 'Ciência da Computação',
          'user_id': 3,
        });

        await db.insert('aluno', {
          'ra': '901234',
          'periodo': 'Diurno',
          'curso': 'Psicologia',
          'user_id': 4,
        });

        await db.insert('aluno', {
          'ra': '567890',
          'periodo': 'Noturno',
          'curso': 'Engenharia Elétrica',
          'user_id': 5,
        });

        await db.insert('materias',
            {'nome': 'Programação II', 'situacao': 'APROVADO', 'media': 7.0});
        await db.insert('materias',
            {'nome': 'Banco de Dados I', 'situacao': 'EXAME', 'media': 6.5});
        await db.insert('materias', {
          'nome': 'Desing de Interiores',
          'situacao': 'APROVADO',
          'media': 9.2
        });
        await db.insert('materias', {
          'nome': 'Arquitetura Moderna',
          'situacao': 'APROVADO',
          'media': 7.0
        });
      },
    );
  }

  Future<int> inserirUsuario(Map<String, dynamic> aluno) async {
    var dbClient = await db;
    return await dbClient.insert('usuario', aluno);
  }

  Future<List<Map<String, dynamic>>> getUsuarios() async {
    var dbClient = await db;
    return await dbClient.query('usuario');
  }

  Future<Map<String, dynamic>?> getUsuarioAluno(int user_id) async {
    var dbClient = await db;

    List<Map<String, dynamic>> result = await dbClient.rawQuery('''
    SELECT * FROM aluno
    INNER JOIN user ON aluno.user_id = user.id
    WHERE user.id = ?
  ''', [user_id]);

    if (result.isNotEmpty) {
      Map<String, dynamic> data = result.first;

      Map<String, dynamic> alunoData = {
        'id': data['id'],
        'ra': data['ra'],
        'periodo': data['periodo'],
        'curso': data['curso'],
      };

      Map<String, dynamic> userData = {
        'id': data['user_id'],
        'nome': data['nome'],
        'sobrenome': data['sobrenome'],
        'senha': data['senha'],
        'idade': data['idade'],
        'email': data['email'],
        'data_nascimento': data['data_nascimento'],
        'sexo': data['sexo'],
        'endereco': data['endereco'],
        'cidade': data['cidade'],
      };

      Aluno aluno = Aluno.fromMap(alunoData);
      User user = User.fromMap(userData);

      return {'aluno': aluno, 'user': user};
    } else {
      return null;
    }
  }

  Future<int> atualizarUsuario(Map<String, dynamic> aluno, int id) async {
    var dbClient = await db;
    return await dbClient
        .update('usuario', aluno, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getMaterias() async {
    var dbClient = await db;
    return await dbClient.query('materias');
  }

  Future<List<Map<String, dynamic>?>> login(String ra, String senha) async {
    var dbClient = await db;

    final result = await dbClient.query(
      'user',
      where: 'email = ? AND senha = ?',
      limit: 1,
      whereArgs: [ra, senha],
    );

    return result;
  }

  Future<int> inserirImagem(Map<String, dynamic> imagem) async {
    var dbClient = await db;
    return await dbClient.insert('inscricao_image', imagem);
  }

  Future<Map<String, dynamic>?> buscarImagemPorTipo(String tipo) async {
    var dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(
      'inscricao_image',
      where: 'tipo = ?',
      whereArgs: [tipo],
    );
    if (result.isNotEmpty) {
      return result.first; 
    }
    return null;
  }
}
