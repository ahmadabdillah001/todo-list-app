import 'package:flutter/material.dart';

class FormDialog extends StatefulWidget {
  final bool isEdit;
  final VoidCallback onPressed;
  final TextEditingController controller;
  const FormDialog({
    super.key,
    this.isEdit = false,
    required this.onPressed,
    required this.controller,
  });

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.isEdit ? 'Edit Todo' : 'Add Todo',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: widget.onPressed,
            child: Text(widget.isEdit ? 'Save' : 'Add'),
          ),
        ],
      ),
    );
  }
}
