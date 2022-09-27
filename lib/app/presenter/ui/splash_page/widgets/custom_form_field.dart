import 'package:flutter/material.dart';
import 'package:habits_now_app/core/constants.dart';

class CustomFormField extends StatefulWidget {
  TextEditingController controller;
  String label;
  IconData icon;
  bool allowVisibility;
  bool hasPassword;
  CustomFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.allowVisibility,
    required this.hasPassword,
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: TextFormField(
            obscureText: !widget.allowVisibility,
            style: kDefaultInputText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            validator: (value) {
              if (value!.isEmpty) {
                return "Campo obrigatório!";
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: kTextFormFieldColor,
              filled: true,
              prefixIcon: Icon(
                widget.icon,
                color: Colors.white,
              ),
              suffix: widget.hasPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.allowVisibility = !widget.allowVisibility;
                        });
                      },
                      icon: Icon(
                        widget.allowVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kTextFormFieldIconColor,
                      ),
                    )
                  : null,
              label: Text(
                widget.label,
                style: kDefaultInputText,
              ),
              labelStyle: kDefaultInputText,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kTextFormFieldColor,
                ),
              ),
              border: const OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kTextFormFieldColor,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        kDefaultMaxSpace,
      ],
    );
  }
}
