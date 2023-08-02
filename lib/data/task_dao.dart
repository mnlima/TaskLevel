// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:task_level/components/task.dart';
import 'package:task_level/data/database.dart';

class TaskDao {
  static const String tableql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_xp INTEGER, '
      '$_nivel INTEGER, '
      '$_image TEXT )';

  static const String _tablename = 'taskTable';
  static const String _name = 'nome';
  static const String _difficulty = 'dificuldade';
  static const String _image = 'imagem';
  static const String _xp = 'xp';
  static const String _nivel = 'nivel';

  save(Task tarefa) async {
    print('save =========================');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap;

    if (itemExists.isEmpty) {
      taskMap = toMap(tarefa);
      print('tarefa nova');
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      tarefa.xp = itemExists[0].xp;
      tarefa.nivel = itemExists[0].nivel;
      taskMap = toMap(tarefa);
      print('Atualizar tarefa ');
      return await bancoDeDados.update(_tablename, taskMap,
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  updateLevel(Task tarefa) async {
    print('update');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);

    print('Atualizar tarefa');
    return await bancoDeDados.update(_tablename, taskMap,
        where: '$_name = ?', whereArgs: [tarefa.nome]);
  }

  Future<List<Task>> findAll() async {
    print('findAll');
    final Database bancoDeDados = await getDatabase();
    List<Map<String, dynamic>> result = await bancoDeDados.query(_tablename);
    print('result:, $result');
    return toList(result);
  }

  Future<List<Task>> find(String nomeTarefa) async {
    print('find');

    final Database bancoDeDados = await getDatabase();

    List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tablename, where: '$_name = ?', whereArgs: [nomeTarefa]);

    print('tarefa encontrada:, $result');

    return toList(result);
  }

  delete(String nomeTarefa) async {
    print('delete');

    final Database bancoDeDados = await getDatabase();

    return bancoDeDados
        .delete(_tablename, where: '$_name = ?', whereArgs: [nomeTarefa]);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('convertendo pra task');
    final List<Task> tarefas = [];

    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty],
          linha[_xp], linha[_nivel]);
      tarefas.add(tarefa);
    }

    print('lista de tarefas: $tarefas');
    return tarefas;
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print('convertendo para map');
    final Map<String, dynamic> mapaDeTarefas = {
      _name: tarefa.nome,
      _difficulty: tarefa.dificuldade,
      _nivel: tarefa.nivel,
      _xp: tarefa.xp,
      _image: tarefa.foto
    };

    // mapaDeTarefas[_name] = tarefa.nome;
    // mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    // mapaDeTarefas[_image] = tarefa.foto;

    return mapaDeTarefas;
  }
}
