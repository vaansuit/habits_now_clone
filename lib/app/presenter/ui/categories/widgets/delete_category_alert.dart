import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../category_repository.dart';

class DeleteCategoryAlert extends StatefulWidget {
  final editCat;
  final VoidCallback setState;
  const DeleteCategoryAlert(
      {Key? key, required this.editCat, required this.setState})
      : super(key: key);

  @override
  State<DeleteCategoryAlert> createState() => _DeleteCategoryAlertState();
}

class _DeleteCategoryAlertState extends State<DeleteCategoryAlert> {
  var box = Hive.box("catBox");

  @override
  Widget build(BuildContext context) {
    //String editCat = widget.editCat;
    CategoryRepository repository = CategoryRepository(box);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        // categoryNameController.clear();
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 20, 20, 20),
            content: Text("A categoria ${widget.editCat} será deletada"),
            actions: [
              TextButton(
                onPressed: () {
                  repository.deleteCategory(widget.editCat);
                  widget.setState();
                  return Navigator.pop(context, 'ok');
                },
                child: const Text('Ok'),
              ),
              TextButton(
                onPressed: () {
                  return Navigator.pop(context, 'cancel');
                },
                child: const Text('Cancelar'),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        );
      },
      child: Row(
        children: const [
          Icon(
            Icons.delete_outline,
            color: Color.fromARGB(255, 95, 94, 94),
          ),
          SizedBox(width: 20),
          Text(
            'Excluir categoria',
            style: TextStyle(
                color: Color.fromARGB(255, 192, 190, 190),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
