import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_level/components/task.dart';
import 'package:task_level/data/task_dao.dart';
import 'package:task_level/data/task_inherited.dart';
import 'package:task_level/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Tarefas'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 80),
        child: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
                break;
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Task tarefa = items[index];
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              items.removeAt(index);
                              TaskDao().delete(tarefa.nome);
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Tarefa removida')),
                            );
                          },
                          background: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              color: Color(0xFFFF5E6C),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        size: 46,
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Remover Tarefa',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          child: tarefa,
                        );
                      },
                    );
                  }

                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color.fromARGB(115, 224, 224, 224),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Nenhuma tarefa cadastrada',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 169, 169, 170),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Text('Erro ao carregar tarefas');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (newContext) => FormScreen(
                taskContext: context,
              ),
            ),
          ).whenComplete(() => {setState(() {})});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
