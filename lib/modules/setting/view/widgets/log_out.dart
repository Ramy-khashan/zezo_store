import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
import '../../../../core/utils/size_config.dart';
import '../../../splash_screen/view/splash_screen.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(  
      title: Row(
        children: [
          Image.asset(
            'assets/images/warning-sign.png',
            width: getWidth(30),
            height: getHeight(30),
          ),
          SizedBox(
            width: getWidth(10),
          ),
          const Text('Sign Out'),
        ],
      ),
      content: Text(
        'Do you wanna sign out?',
        style: TextStyle(fontSize: getFont(22)),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Text(
            'Cancel',
            style:
                TextStyle(  fontSize: getFont(22)),
          ),
        ),
        TextButton(
          onPressed: () async {
            await const FlutterSecureStorage().deleteAll().then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            });
          },
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.red.shade700, fontSize: getFont(22)),
          ),
        ),
      ],
    ),
  );
}
