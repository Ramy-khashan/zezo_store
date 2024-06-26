import 'dart:io';

import 'package:flutter/material.dart'; 

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey.withOpacity(.6),
            )
          : Platform.isIOS
              ? const CircularProgressIndicator.adaptive()
              : const LinearProgressIndicator(),
    );
  }
}
