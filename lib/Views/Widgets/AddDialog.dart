import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onCancel;
  VoidCallback onAdded;
  AddDialog(
      {required this.controller,
      required this.onAdded,
      required this.onCancel});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(" ajouter une liste"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: "entrez le nom de la liste"),
      ),
      actions: [
        TextButton(onPressed: onAdded, child: const Text("Ajouter")),
        TextButton(onPressed: onCancel, child: const Text("Annuler")),
      ],
    );
  }
}
