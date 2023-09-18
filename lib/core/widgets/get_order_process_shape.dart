import 'package:flutter/material.dart';

import '../utils/size_config.dart';
import 'loading_item.dart';

class GetSpecialOrderShape extends StatelessWidget {
  const GetSpecialOrderShape({super.key, required this.status});
  final String status;
  @override
  Widget build(BuildContext context) {
    return status == "in_progress"
        ? const LoadingItem()
        : status == "accepted"
            ? CircleAvatar(
              radius: getWidth(20),

                backgroundColor: Colors.green,
                child: Icon(Icons.done,size: getWidth(32),),
              )
            : CircleAvatar(
              radius: getWidth(20),
                backgroundColor: Colors.red,
                child: Icon(Icons.close,size: getWidth(32),),
              );
  }
}
