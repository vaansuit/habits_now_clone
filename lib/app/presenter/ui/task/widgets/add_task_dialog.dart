import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habits_now_app/core/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../calendar/events.dart';

class AddTaskDialog extends ConsumerStatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends ConsumerState<AddTaskDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController calendarTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // String title = '';
  // String description = '';
  // String calendarTime = '';
  Future<void> saveTask(
      String title, String description, String calendarTime) async {
    var url = Uri.parse('http://zuplae.vps-kinghost.net:8081/api/duty');

    var body = jsonEncode(
      {
        "title": title,
        "description": "description",
        "category": description,
        "calendar": calendarTime,
        "userEmail": "carlos"
      },
    );
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      Event eventin = Event("Tarefa: $title");
      DateTime tasksDate = DateFormat.yMd("pt_BR").parseUTC(calendarTime);
      if (kEvents[tasksDate] != null) {
        kEvents[tasksDate]!.add(eventin);
      } else {
        kEvents[tasksDate] = [eventin];
      }
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Adicione uma tarefa!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(height: 8),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(
                            'Tarefa',
                          ),
                        ),
                        controller: titleController,
                        validator: (value) {
                          return value!.isEmpty
                              ? "O campo Tarefa n??o pode estar vazio!"
                              : null;
                        },
                      ),
                      kDefaultMinSpace,
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text(
                            'Categoria',
                          ),
                        ),
                        controller: descriptionController,
                        validator: (value) {
                          return value!.isEmpty
                              ? "O campo Tarefa n??o pode estar vazio!"
                              : null;
                        },
                      ),
                      kDefaultMinSpace,
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter()
                        ],
                        decoration: const InputDecoration(
                          label: Text(
                            'Informe uma data',
                          ),
                        ),
                        controller: calendarTimeController,
                        validator: (value) {
                          return value!.isEmpty
                              ? "O campo Tarefa n??o pode estar vazio!"
                              : null;
                        },
                      ),
                      kDefaultMaxSpace,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              saveTask(
                                  titleController.text,
                                  descriptionController.text,
                                  calendarTimeController.text);
                            }
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: const Text('Salvar Tarefa'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
