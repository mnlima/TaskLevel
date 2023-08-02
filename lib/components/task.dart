import 'package:flutter/material.dart';
import 'package:task_level/components/difficulty.dart';
import 'package:task_level/data/task_dao.dart';

// ignore: must_be_immutable
class Task extends StatefulWidget {
  final String nome;
  final String foto;
  int dificuldade;
  Task(this.nome, this.foto, this.dificuldade, {super.key});

  int xp = 0;
  int nivel = 1;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final Map<int, Color> cores = {
    1: Colors.blue,
    2: const Color.fromARGB(255, 1, 151, 197),
    3: const Color.fromARGB(255, 0, 187, 201),
    4: const Color.fromARGB(255, 0, 182, 167),
    5: const Color.fromARGB(255, 0, 182, 143),
  };

  bool assetsOrNetwork() {
    return widget.foto.contains('http') ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: cores[widget.nivel] ?? cores[5]),
            height: 140,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 92,
                      height: 100,
                      color: Colors.black12,
                      child: assetsOrNetwork()
                          ? Image.asset(
                              widget.foto,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              widget.foto,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.nome,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Difficulty(
                            difficultyLevel: widget.dificuldade,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                            onLongPress: () {
                              TaskDao().delete(widget.nome);
                            },
                            onPressed: () {
                              setState(() {
                                if (widget.xp >= widget.dificuldade * 11) {
                                  setState(() {
                                    widget.xp = 0;
                                    widget.nivel++;
                                  });
                                } else {
                                  setState(() {
                                    widget.xp++;
                                  });
                                }
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(Icons.arrow_drop_up),
                                Text(
                                  'UP',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SizedBox(
                          width: 200,
                          child: LinearProgressIndicator(
                            color: Colors.white,
                            value: (widget.xp /
                                    ((widget.dificuldade > 0)
                                        ? widget.dificuldade
                                        : 1)) /
                                11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('nível: ${widget.nivel}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'xp: ${widget.xp}/${widget.dificuldade * 11}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
