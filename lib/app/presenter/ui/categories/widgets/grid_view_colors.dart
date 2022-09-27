import 'package:flutter/material.dart';


class GridViewColors extends StatelessWidget {
  const GridViewColors({
    Key? key, required this.setModalState, 
  }) : super(key: key);
 final Function(int)  setModalState;
  

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      children: [
        ColorOption(setModalState: setModalState, color: Colors.yellow),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 255, 154, 59)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 255, 85, 59)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 255, 59, 92)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 255, 59, 92)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 255, 59, 167)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 255, 59, 216)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 229, 59, 255)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 173, 59, 255)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 118, 59, 255)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 79, 59, 255)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 59, 101, 255)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 59, 173, 255)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 59, 232, 255)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 59, 255, 216)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 59, 255, 154)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 59, 255, 88)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 92, 255, 59)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 50, 182, 24)),
        ColorOption(setModalState: setModalState, color: const Color.fromARGB(255, 97, 162, 37)),
      ],
    );
  }
}

class ColorOption extends StatelessWidget {
  const ColorOption({
    Key? key,
    required this.setModalState, required this.color
  }) : super(key: key);

  final Function(int p1) setModalState;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          setModalState(color.value);              
                     
          Navigator.pop(context, 'OK');
        },
        child: Icon(
          Icons.circle,
          color: color,
          size: 55,
        ),
      ),
    );
  }
}