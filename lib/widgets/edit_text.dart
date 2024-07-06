import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  TextEditingController? textEditingController;
  IconData? iconData;
  String? hintString;
  bool? isPass = true;
  bool? enabled = true;
  TextInputType? type;

  EditText({super.key, this.textEditingController, this.iconData,
    this.hintString, this.isPass, this.enabled, this.type});

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
          color: Colors.green
        ),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        enabled: widget.enabled,
        controller: widget.textEditingController,
        obscureText: widget.isPass!,
        keyboardType: widget.type,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.iconData,
            color: Colors.green,
          ),
          hintText: widget.hintString,
          hintStyle: const TextStyle(
            color: Colors.grey
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0)
        ),
      ),
    );
  }
}
