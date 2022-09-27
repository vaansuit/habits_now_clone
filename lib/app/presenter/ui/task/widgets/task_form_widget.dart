import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final String calendar;
  final TextEditingController controller;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<String> onCalendarChanged;
  final VoidCallback onSaveTask;

  const TaskFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    this.calendar = '',
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    required this.onCalendarChanged,
    required this.onSaveTask,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(
            height: 8,
          ),
          buildDescription(),
          const SizedBox(
            height: 8,
          ),
          buildCalendar(),
          const SizedBox(
            height: 8,
          ),
          buildButton()
        ],
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        initialValue: title,
        onChanged: onTitleChanged,
        controller: controller,
        validator: (title) {
          if (title!.isEmpty) {
            return 'O campo "Tarefa" não pode estar vazio!';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Tarefa',
        ),
      );

  Widget buildDescription() => TextFormField(
        initialValue: description,
        onChanged: onDescriptionChanged,
        controller: controller,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Categoria',
        ),
      );

  Widget buildCalendar() => TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          DataInputFormatter()
        ],
        initialValue: calendar,
        onChanged: onCalendarChanged,
        controller: controller,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Informe uma data',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSaveTask,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          child: const Text('Salvar Tarefa'),
        ),
      );
}
