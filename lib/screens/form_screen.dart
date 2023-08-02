import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_level/components/task.dart';
import 'package:task_level/data/task_dao.dart';
import 'package:task_level/data/task_inherited.dart';
import 'package:image_picker/image_picker.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  String imagePath = '';
  final _formKey = GlobalKey<FormState>();

  bool isImageSelected = false;
  bool isSaveButtonPressed = false;

  bool valueValidator(String? value) {
    return (value != null && value.isEmpty) ? true : false;
  }

  bool difficultyValidator(String? value) {
    return (value != null && value.isEmpty) ? true : false;
  }

  bool rangeValidator(String value) {
    return (int.parse(value) > 5 || int.parse(value) < 1) ? true : false;
  }

  Future<void> selecionarImagemGaleria() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Aqui você pode usar a imagem selecionada
      setState(() {
        imagePath = pickedImage.path;
        isImageSelected = true;
        isSaveButtonPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(64),
                      topRight: Radius.circular(64),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(children: [
                      const SizedBox(
                        height: 64,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Container(
                          width: 92,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDEFF0),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: (!isImageSelected && isSaveButtonPressed)
                                  ? Color(0xFFB64242)
                                  : Color(0xFF8F969B),
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: imagePath != null
                                  ? Image.file(
                                      File(imagePath),
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 12,
                                          ),
                                          child: Image.asset(
                                              'assets/images/nophoto.png'),
                                        );
                                      },
                                    )
                                  : Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      child: Image.asset(
                                          'assets/images/nophoto.png'),
                                    )),
                        ),
                      ),
                      if (!isImageSelected && isSaveButtonPressed)
                        Text(
                          "Selecione uma imagem",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 40,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            selecionarImagemGaleria();
                          },
                          child: Text('Abrir galeria'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 40,
                        ),
                        child: TextFormField(
                          controller: nameController,
                          validator: (String? value) {
                            return (valueValidator(value))
                                ? 'Insira o nome da tarefa!'
                                : null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Nome',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 40,
                        ),
                        child: TextFormField(
                          controller: difficultyController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            return (difficultyValidator(value))
                                ? 'Insira a dificuldade da tarefa!'
                                : (int.parse(value!) > 5 ||
                                        int.parse(value) < 1)
                                    ? 'Insira uma dificuldade entre 1 e 5'
                                    : null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Dificuldade',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSaveButtonPressed = true;
                          });
                          if (_formKey.currentState!.validate() &&
                              imagePath.isNotEmpty) {
                            // print(nameController.text);
                            // print(difficultyController.text);
                            // print(imagePath);
                            int xp = 0;
                            int nivel = 0;
                            TaskDao().save(Task(
                              nameController.text,
                              imagePath,
                              int.parse(difficultyController.text),
                              xp,
                              nivel,
                            ));

                            // TaskInherited.of(widget.taskContext).newTask(
                            //   nameController.text,
                            //   imagePath,
                            //   int.parse(difficultyController.text),
                            // );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Criando nova tarefa'),
                              ),
                            );
                            Navigator.pop(context, true);
                          }
                        },
                        child: const Text('Adicionar'),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
