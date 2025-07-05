import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  final String data;
  final VoidCallback onPress;
  const DeleteDialog({super.key, required this.data, required this.onPress});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Hapus ${widget.data}'),
      content: ElevatedButton(onPressed: widget.onPress, child: Text('Hapus')),
    );
  }
}
