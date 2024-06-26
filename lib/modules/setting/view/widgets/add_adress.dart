import 'package:flutter/material.dart';

updateAddressDialog(context)  {
  return  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Update'),
      content: TextField(
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: 'Your Address',
        ),
        onChanged: (value) {},
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Update'),
        ),
      ],
    ),
  );
}
